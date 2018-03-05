module WoocommerceAPI
  module V1
    class CouponLine < Resource
      attribute :id, Integer
      attribute :code
      attribute :amount, Decimal
      def meta_data
        []
      end
    end
  end
end
