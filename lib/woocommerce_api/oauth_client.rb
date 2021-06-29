require 'woocommerce_api/concerns/request_headers'
require 'woocommerce_api/services/http_request_method'

module WoocommerceAPI
  class OauthClient
    include HTTParty
    include WoocommerceAPI::RequestHeaders

    def self.perform_request(http_method, path, options = {}, &block)
      ActiveSupport::Notifications.instrument("request.woocommerce_api") do |payload|
        http_method = HTTPRequestMethod.request_method(http_method, options)
        request_uri = oauth_url(http_method, path)

        payload[:method]        = http_method::METHOD.downcase
        payload[:request_uri]   = request_uri
        payload[:request_body]  = options[:body]
        options[:headers]       = set_request_headers(options, http_method::METHOD)
        payload[:response_body] = super(http_method, request_uri, options, &block)
      end
    end

  private

    def self.oauth_url(http_method, path, params={})
      oauth_options = Thread.current["WoocommerceAPI"]
      parsed_url = URI::parse("#{oauth_options[:base_uri]}#{path}")

      if parsed_url.query
        CGI::parse(parsed_url.query).each do |key, value|
          if key.include?('[]')
            value.each_with_index do |v, i|
              params[key.gsub("[]", "[#{i}]")] = v
            end
          else
            params[key] = value[0]
          end
        end
        params = Hash[params.sort]
      end

      url = "http://#{parsed_url.host}#{parsed_url.path}"

      consumer_secret = if oauth_options[:version] == "v3" || oauth_options[:wordpress_api]
                          "#{oauth_options[:oauth_consumer_secret]}&"
                        else
                          oauth_options[:oauth_consumer_secret]
                        end

      params["oauth_consumer_key"] = oauth_options[:oauth_consumer_key]
      params["oauth_nonce"] = SecureRandom.hex
      params["oauth_signature_method"] = "HMAC-SHA256"
      params["oauth_timestamp"] = Time.new.to_i
      params["oauth_signature"] = CGI::escape(generate_oauth_signature(http_method, url, params, consumer_secret))

      query_string = URI.encode_www_form(params)

      "#{url}?#{query_string}"
    end

    def self.generate_oauth_signature(http_method, url, params, consumer_secret)
      base_request_uri = CGI::escape(url.to_s)
      query_params = params.sort.map do |key, value|
        encode_param(key.to_s) + "%3D" + encode_param(value.to_s)
      end

      query_string = query_params.join("%26")
      string_to_sign = "#{http_method::METHOD}&#{base_request_uri}&#{query_string}"

      return Base64.strict_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), consumer_secret, string_to_sign))
    end

    def self.encode_param(text)
      CGI::escape(text).gsub("+", "%20").gsub("%", "%25")
    end
  end
end
