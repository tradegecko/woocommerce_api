module WoocommerceAPI
  class Client
    include HTTParty
    format :json
    headers 'Accept' => "application/json"
    headers 'Content-Type' => "application/json"
    debug_output

    def initialize(params={})
      self.class.basic_auth params[:consumer_key], params[:consumer_secret]
      self.class.base_uri(params[:store_url] + '/wc-api/v2/')
    end
  end
end
