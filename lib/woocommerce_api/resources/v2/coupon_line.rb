require "woocommerce_api/resources/meta_datum"
module WoocommerceAPI
  module V2
    class CouponLine < Resource
      attribute :id, Integer
      attribute :code
      attribute :amount, Decimal
      attribute :meta_data, Array[MetaDatum], writer: :private
    end
  end
end
