module WoocommerceAPI
  class Client
    include HTTParty
    debug_output

    def self.default_options
      Thread.current["WoocommerceAPI"] ||= {
        parser: HTTParty::Parser,
        format: :json,
        headers: { "Accept" => "application/json", "Content-Type" => "application/json" }
      }
    end

    def initialize(params={})
      session_options = self.class.default_options
      session_options[:basic_auth] = { username: params[:consumer_key], password: params[:consumer_secret] }
      session_options[:base_uri] = HTTParty.normalize_base_uri(params[:store_url] + '/wc-api/v2')
      Thread.current["WoocommerceAPI"] = session_options
    end
  end
end
