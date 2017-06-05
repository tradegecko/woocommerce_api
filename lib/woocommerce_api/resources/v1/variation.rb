require "woocommerce_api/resources/legacy/image"
require "woocommerce_api/resources/legacy/dimensions"

module WoocommerceAPI
  module V1
    class Variation < Resource
      def load(attributes)
        # Rename restricted attributes
        if attributes['attributes']
          attributes['wc_attributes'] = attributes.delete('attributes')
        end
        super
      end

      def as_json(options={})
        wc_attributes = super(options)
        if attributes[:wc_attributes] && !attributes[:wc_attributes].empty?
          wc_attributes['attributes'] = attributes[:wc_attributes]
        end

        wc_attributes.delete('image') unless options[:images]
        wc_attributes
      end

      attribute :id, Integer
      attribute :wc_attributes, Array
      attribute :backorders
      attribute :date_on_sale_from , DateTime
      attribute :date_on_sale_to , DateTime
      attribute :dimensions, Dimensions
      attribute :download_expiry, Integer
      attribute :download_limit, Integer
      attribute :downloadable, Boolean
      attribute :downloads, Array
      attribute :image, Array[Image]
      attribute :in_stock, Boolean
      attribute :manage_stock, Boolean
      attribute :regular_price, Decimal
      attribute :sale_price, Decimal
      attribute :shipping_class
      attribute :sku
      attribute :stock_quantity, Integer
      attribute :tax_class
      attribute :tax_status
      attribute :virtual, Boolean
      attribute :visible, Boolean
      attribute :weight

      # Read Only
      attribute :backordered       , Boolean , writer: :private
      attribute :backorders_allowed, Boolean , writer: :private
      attribute :date_created      , DateTime, writer: :private
      attribute :date_modified     , DateTime, writer: :private
      attribute :permalink         , String  , writer: :private
      attribute :price             , Decimal , writer: :private
      attribute :on_sale           , Boolean , writer: :private
      attribute :purchasable       , Boolean , writer: :private
    end
  end
end
