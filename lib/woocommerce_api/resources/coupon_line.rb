module WoocommerceAPI
  class CouponLine < Resource
    attribute :id, Integer
    attribute :code
    attribute :amount, Decimal
  end
end
