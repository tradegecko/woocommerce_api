module WoocommerceAPI
  # Sets the HTTP request headers when making an API call to Woocommerce
  module RequestHeaders
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def set_request_headers(options, http_method)
        headers = options[:headers] || {}
        headers['Content-Type'] = 'application/json' if valid_json?(options[:body])
        headers['X-HTTP-Method-Override'] = http_method if http_method_override_header?(options, http_method)

        headers
      end

      # https://developer.wordpress.org/rest-api/using-the-rest-api/global-parameters/#_method-or-x-http-method-override-header
      def http_method_override_header?(options, http_method)
        http_method != 'GET' && http_method != 'POST' && options.key?(:http_method_override)
      end

      def valid_json?(json)
        return false if json.nil?

        JSON.parse(json)
        return true
      rescue JSON::ParserError => e
        return false
      end
    end
  end
end
