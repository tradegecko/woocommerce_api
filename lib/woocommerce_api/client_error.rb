module WoocommerceAPI
  class ClientError < StandardError
    attr_accessor :code
    def initialize(code, response)
      @code = code
      message = case code
                when 403, 404, 408
                  response.body
                when 500
                  "Internal Server Error"
                else
                  extract_response(response.parsed_response)
                end
      super(message)
    rescue
      # There are cases where calling just response would raise a JSON::ParserError
      # but response.body and response.code would be returned normally.
      super(response.body)
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
end
