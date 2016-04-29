module WoocommerceAPI
  class ClientError < StandardError
    attr_accessor :code
    def initialize(code, response)
      @code = code
      message = case code
                when 408
                  response.to_s
                when 500
                  "Internal Server Error"
                else
                  extract_response(response.parsed_response)
                end
      super(message)
    end

  private

    def extract_response(response)
      case response
      when Array
        response.map{ |value| extract_response(value) }.join(', ')
      when Hash
        @code = response['code'] if response.has_key? 'code'
        extract_response(response.values)
      else
        response.to_s.gsub(/[,.]$/, '')
      end
    end

  end

  class Resource
    include Virtus.model
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON
    include WoocommerceAPI::Singleton
    include WoocommerceAPI::Associations
    include WoocommerceAPI::AttributeAssignment
    TIMEOUT_OPTIONS = {timeout: 30}
    self.include_root_in_json = true

    def initialize(params={})
      params.each do |attr, value|
        self.send("#{attr}=", value) if self.respond_to?("#{attr}=")
      end if params

      super()
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

      response.success? ? response : raise(ClientError.new(response.code, response))
    rescue Net::ReadTimeout => ex
      raise ClientError.new(408, ex)
    end
  end # Resource
end
