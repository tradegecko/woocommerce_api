require 'woocommerce_api/services/http_method_override'

module WoocommerceAPI
  # Determines the HTTP verb to use when making an API request
  class HTTPRequestMethod
    attr_reader :http_method, :options

    def self.request_method(http_method, options)
      new(http_method, options).request_method
    end

    def initialize(http_method, options)
      @http_method = http_method
      @options = options
    end

    def request_method
      return Net::HTTP::Post if HTTPRequestOverride.http_method_override_header?(http_method, options)

      http_method
    end
  end
end
