module WoocommerceAPI
  class Client
    include HTTParty

    def self.default_options
      Thread.current["WoocommerceAPI"] || raise("Session has not been activated yet")
    end
  end
end
