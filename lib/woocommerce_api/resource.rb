module WoocommerceAPI
  class ClientError < StandardError
    attr_accessor :code
    def initialize(code, message)
      @code = code
      super(message)
    end
  end

  class Resource
    include Virtus.model
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON
    include WoocommerceAPI::Singleton
    include WoocommerceAPI::Associations
    include WoocommerceAPI::AttributeAssignment
    self.include_root_in_json = true

    def self.http_request(verb, url, options={})
      response = begin
        if WoocommerceAPI::Client.default_options[:mode] == :oauth_http
          WoocommerceAPI::OauthClient.send(verb, url, options)
        else
          WoocommerceAPI::Client.send(verb, url, options)
        end
      end

      if response.success?
        response
      else
        response_error = response["errors"].first
        raise ClientError.new(response_error["code"], response_error["message"])
      end
    end
  end # Resource
end
