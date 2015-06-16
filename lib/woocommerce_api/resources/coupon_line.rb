module WoocommerceAPI
  class CouponLine < Resource
    attribute :id, Integer
    attribute :code
    attribute :amount, Decimal

    def coupon
      Coupon.find_by_code(code)
    end
  end
end
