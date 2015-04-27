require "woocommerce_api/resources/image"

module WoocommerceAPI
  class Variation < Resource
    attribute :id, Integer
    attribute :custom_attributes
    attribute :dimensions, Dimensions
    attribute :download_expiry, Integer
    attribute :download_limit, Integer
    attribute :downloadable, Boolean
    attribute :downloads, Array
    attribute :image
    attribute :images, Array[Image]
    attribute :in_stock, Boolean
    attribute :managing_stock, Boolean
    attribute :regular_price, Decimal
    attribute :sale_price, Decimal
    attribute :shipping_class
    attribute :sku
    attribute :stock_quantity, Integer
    attribute :tax_class
    attribute :tax_status
    attribute :virtual, Boolean
    attribute :weight

    # Read Only
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
    attribute :backordered, Boolean
    attribute :on_sale, Boolean
    attribute :permalink
    attribute :price, Decimal
    attribute :purchaseable, Boolean
    attribute :shipping_class_id, Integer
    attribute :taxable, Boolean
    attribute :visible, Boolean

    # Write Only
    attribute :sale_price_dates_from, DateTime
    attribute :sale_price_dates_to, DateTime
  end
end
