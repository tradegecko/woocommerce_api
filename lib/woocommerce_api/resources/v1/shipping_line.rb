module WoocommerceAPI
  module V1
    class ShippingLine < Resource
      attribute :id, Integer
      attribute :method_id, Integer
      attribute :method_title
      attribute :total, Decimal
      attribute :total_tax, Decimal
      attribute :taxes, Array[Hash]
    end
  end
end
