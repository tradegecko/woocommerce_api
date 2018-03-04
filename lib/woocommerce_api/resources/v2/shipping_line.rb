require "woocommerce_api/resources/meta_datum"
module WoocommerceAPI
  module V2
    class ShippingLine < Resource
      attribute :id, Integer
      attribute :method_id, Integer
      attribute :method_title
      attribute :total, Decimal
      attribute :total_tax, Decimal
      attribute :taxes, Array[Hash]
      attribute :meta_data , Array[MetaDatum], writer: :private
    end
  end
end
