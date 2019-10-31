require 'woocommerce_api/services/http_method_override'

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
        headers['X-HTTP-Method-Override'] = http_method if HTTPRequestOverride.http_method_override_header?(http_method, options)

        headers
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
