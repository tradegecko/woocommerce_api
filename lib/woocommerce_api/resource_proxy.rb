module WoocommerceAPI
  class ResourceProxy
    include Virtus.model
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON
    include WoocommerceAPI::Singleton
    include WoocommerceAPI::AttributeAssignment
    include WoocommerceAPI::ParamsConverter
    TIMEOUT_OPTIONS = {timeout: 30}

    attr_reader :raw_params, :model
    delegate :attributes, to: :model

    def initialize(params={})
      @raw_params = params.dup
      @model = version_model.new(params)
    end

    def self.legacy_api?
      !WoocommerceAPI::Client.default_options[:wordpress_api]
    end

    def method_missing(method, *args, &block)
      @model.send(method, *args, &block)
    end

    def self.http_request(verb, url, options={})
      header_request = options.delete(:header_request)
      options = TIMEOUT_OPTIONS.merge(options)
      response = begin
        if WoocommerceAPI::Client.default_options[:mode] == :oauth_http
          WoocommerceAPI::OauthClient.send(verb, url, options)
        else
          WoocommerceAPI::Client.send(verb, url, options)
        end
      end

      if response.success?
        begin
          if header_request
            response.headers
          else
            parse_response(response)
          end
        rescue JSON::ParserError => ex
          raise(ClientError.new('woocommerce_parse_json_error', response))
        rescue Net::ReadTimeout => ex
          raise ClientError.new(408, ex)
        end
      else
        raise(ClientError.new(response.code, response))
      end
    end

    def self.parse_response(response)
      JSON.parse(response.body.match(/({.*}|\[.*\])/).to_s)
    end

    def respond_to?(method, include_private=false)
      @model.respond_to?(method) || super
    end

    def reload
      return unless persisted?
      self.load(self.class.find(self.id).model.attributes)
    end

    def as_json(options={})
      self.model.as_json(options)
    end

  private

    def version_model
      current_version = if !!WoocommerceAPI::Client.default_options[:wordpress_api]
                          WoocommerceAPI::Client.default_options[:version]&.upcase
                        else
                          'V3'
                        end

      "WoocommerceAPI::#{current_version}::#{singleton_name.classify}".constantize
    end
  end
end
