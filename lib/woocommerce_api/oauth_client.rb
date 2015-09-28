module WoocommerceAPI
  class OauthClient
    include HTTParty

    def self.get(path, options = {}, &block)
      super(oauth_url(:get, path, options), {}, &block)
    end

    def self.put(path, options = {}, &block)
      super(oauth_url(:put, path, options), {}, &block)
    end

    def self.post(path, options = {}, &block)
      super(oauth_url(:post, path, options), {}, &block)
    end

    def self.delete(path, options = {}, &block)
      super(oauth_url(:delete, path, options), {}, &block)
    end

  private

    def self.oauth_url(verb, path, params={})
      oauth_options = Thread.current["WoocommerceAPI"]
      parsed_url = URI::parse("#{oauth_options[:base_uri]}#{path}")
      if parsed_url.query
        CGI::parse(parsed_url.query).each do |key, value|
          params[key] = value[0]
        end
      end
      url = "http://#{parsed_url.host}#{parsed_url.path}"
      consumer_secret = if oauth_options[:version] == "v3"
                          "#{oauth_options[:oauth_consumer_secret]}&"
                        else
                          oauth_options[:oauth_consumer_secret]
                        end

      params["oauth_consumer_key"] = oauth_options[:oauth_consumer_key]
      params["oauth_nonce"] = SecureRandom.hex
      params["oauth_signature_method"] = "HMAC-SHA256"
      params["oauth_timestamp"] = Time.new.to_i
      params["oauth_signature"] = CGI::escape(generate_oauth_signature(verb, url, params, consumer_secret))

      query_string = URI::encode(params.map{ |key, value| "#{key}=#{value}"}.join("&"))

      "#{url}?#{query_string}"
    end

    def self.generate_oauth_signature(verb, url, params, consumer_secret)
      base_request_uri = CGI::escape(url.to_s)
      query_params = params.sort.map do |key, value|
        encode_param(key.to_s) + "%3D" + encode_param(value.to_s)
      end

      query_string = query_params.join("%26")
      string_to_sign = "#{verb.to_s.upcase}&#{base_request_uri}&#{query_string}"

      return Base64.strict_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), consumer_secret, string_to_sign))
    end

    def self.encode_param(text)
      CGI::escape(text).gsub('%', '%25')
    end
  end
end
