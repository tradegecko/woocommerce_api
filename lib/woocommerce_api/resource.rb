module WoocommerceAPI
  class Resource
    include Virtus.model
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON
    include WoocommerceAPI::Singleton
    include WoocommerceAPI::Associations
    include WoocommerceAPI::AttributeAssignment
    TIMEOUT_OPTIONS = {timeout: 30}
    self.include_root_in_json = true

    attr_reader :raw_params

    def initialize(params={})
      @raw_params = params.dup
      load(params)
      super()
    end

    def load(params)
      params.each do |attr, value|
        self.send("#{attr}=", value) if self.respond_to?("#{attr}=", true)
      end if params
      self
    end

    def self.http_request(verb, url, options={})
      options = TIMEOUT_OPTIONS.merge(options)
      response = begin
        if WoocommerceAPI::Client.default_options[:mode] == :oauth_http
          WoocommerceAPI::OauthClient.send(verb, url, options)
        else
          WoocommerceAPI::Client.send(verb, url, options)
        end
      end

      if response.success?
        # Restric format to be JSON
        begin
          parse_response(response)
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
      JSON.parse(response.body.match(/({.*})/).to_s)
    end
  end # Resource
end
