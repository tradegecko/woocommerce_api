module WoocommerceAPI
  class Client
    include HTTParty
    def self.default_options
      Thread.current["WoocommerceAPI"] ||= {
        parser: HTTParty::Parser,
        format: :json,
        headers: { "Accept"       => "application/json",
                   "Content-Type" => "application/json",
                   "User-Agent"   => "TradeGecko Woocommerce/#{VERSION}" }
      }
    end


    def initialize(params={})
      client_options = case params[:mode]
                       when :query_https
                         query_https_options(params)
                       when :oauth_http
                         oauth_http_options(params)
                       else #:oauth_https
                         oauth_https_options(params)
                       end
      client_options[:version] = params.delete(:version) || 'v2'
      client_options[:base_uri] = normalize_base_uri(params[:store_url], client_options[:version])
      session_options = self.class.default_options.merge(client_options)
      Thread.current["WoocommerceAPI"] = session_options
    end

  private

    def oauth_http_options(params)
      { oauth_consumer_key: params[:consumer_key],
        oauth_consumer_secret: params[:consumer_secret],
        mode: :oauth_http }
    end

    def oauth_https_options(params)
      { basic_auth: {
          username: params[:consumer_key],
          password: params[:consumer_secret]
        },
        mode: :oauth_https }
    end

    def query_https_options(params)
      { query: params.slice(:consumer_key, :consumer_secret),
        mode: :query_https }
    end

    def normalize_base_uri(uri, version)
      HTTParty.normalize_base_uri(uri.sub(/(\/)+$/,'') + "/wc-api/#{version}" )
    end
  end
end
