module WoocommerceAPI
  module V1
    class CouponLine < Resource
      attribute :id, Integer
      attribute :code
      attribute :amount, Decimal
    end
  end
end
