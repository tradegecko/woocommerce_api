module WoocommerceAPI
  class LineItem < Resource
    attribute :id, Integer
    attribute :product_id, Integer
    attribute :quantity, Integer
    attribute :subtotal, Decimal
    attribute :subtotal_tax, Decimal
    attribute :total, Decimal
    attribute :total_tax, Decimal

    # Read Only
    attribute :sku
    attribute :name
    attribute :price, Decimal
    attribute :tax_class

    attribute :meta

    # Write Only
    attribute :variations
  end
end
