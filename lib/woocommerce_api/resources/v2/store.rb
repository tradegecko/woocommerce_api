module WoocommerceAPI
  module V2
    class Store < Resource
      attribute :namespace
      attribute :routes, Hash

      def self.details
        extract_resource(http_request(:get, "/"))
      end
    end
  end
end
