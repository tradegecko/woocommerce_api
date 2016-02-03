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
    attribute :sku, String, writer: :private
    attribute :name, String, writer: :private
    attribute :price, Decimal, writer: :private
    attribute :tax_class, String, writer: :private
    attribute :meta, Array[Hash], writer: :private

    # Write Only
    attribute :variations, Array[Hash], reader: :private
  end
end
