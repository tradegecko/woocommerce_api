require "woocommerce_api/resources/image"
require "woocommerce_api/resources/dimensions"

module WoocommerceAPI
  class Variation < Resource
    def initialize(attributes={})
      # Rename restricted attributes
      if attributes['attributes']
        attributes['wc_attributes'] = attributes.delete('attributes')
      end
      super
    end

    def as_json(options=nil)
      wc_attributes = super
      if attributes[:wc_attributes] && !attributes[:wc_attributes].empty?
        if options && !options[:root]
          wc_attributes['attributes'] = attributes[:wc_attributes]
        else
          wc_attributes['variation']['attributes'] = attributes[:wc_attributes]
        end
      end
      wc_attributes
    end

    attribute :id, Integer
    attribute :wc_attributes, Array
    attribute :dimensions, Dimensions
    attribute :download_expiry, Integer
    attribute :download_limit, Integer
    attribute :downloadable, Boolean
    attribute :downloads, Array
    attribute :image, Array[Image]
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
    attribute :backorders
    attribute :sale_price_dates_from, DateTime
    attribute :sale_price_dates_to, DateTime
  end
end

