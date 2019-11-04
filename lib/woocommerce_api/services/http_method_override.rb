module WoocommerceAPI
  # Determines if the API request should be send with a X-HTTP-Method-Override header
  # https://developer.wordpress.org/rest-api/using-the-rest-api/global-parameters/#_method-or-x-http-method-override-header
  class HTTPRequestOverride
    attr_reader :http_method, :options

    def self.http_method_override_header?(http_method, options)
      new(http_method, options).http_method_override_header?
    end

    def initialize(http_method, options)
      @http_method = http_method
      @options = options
    end

    def http_method_override_header?
      http_method != 'GET' && http_method != 'POST' && options[:http_method_override] == true
    end
  end
end

