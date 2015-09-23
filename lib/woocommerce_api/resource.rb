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
        if WoocommerceAPI::Client.default_options[:test_mode]
          url = WoocommerceAPI::Client.default_options[:base_uri] + url
          consumer_key = WoocommerceAPI::Client.default_options[:query][:consumer_key]
          consumer_secret = WoocommerceAPI::Client.default_options[:query][:consumer_secret]
          oauth = WoocommerceAPI::Oauth.new(url, verb, 'v2', consumer_key, consumer_secret)
          # Not sure why WoocommerceAPI::Client.send(verb, url, options) won't work
          # So I'm calling HTTParty direct on this one
          HTTParty.send(verb, oauth.get_oauth_url, options)
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
