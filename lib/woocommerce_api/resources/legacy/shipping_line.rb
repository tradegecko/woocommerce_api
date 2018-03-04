module WoocommerceAPI
  module V3
    class ShippingLine < Resource
      attribute :id, Integer
      attribute :method_id, Integer
      attribute :method_title
      attribute :total, Decimal

      def meta_data
        []
      end
    end
  end
end
