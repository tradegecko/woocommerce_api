require "woocommerce_api/resources/legacy/image"
require "woocommerce_api/resources/legacy/dimensions"

module WoocommerceAPI
  module V2
    class Variation < Resource
      include WoocommerceAPI::AttributeSlicer

      def load(attributes)
        # Rename restricted attributes
        if attributes['attributes']
          attributes['wc_attributes'] = attributes.delete('attributes')
        end
        super
      end

      def as_json(options={})
        variant_attributes = super(options)

        variant_options = variant_attributes.delete(:wc_attributes)
        variant_attributes['attributes'] = variant_options if variant_options.present?

        variant_attributes.delete('image') unless options[:images]
        variant_attributes.delete('manage_stock') if variant_attributes['manage_stock'] == 'parent'
        variant_attributes['backorders'] = nil if variant_attributes['backorders'].blank?

        slice_by_sync_type(options[:sync_type], variant_attributes)
      end

      attribute :id, Integer
      attribute :backorders
      attribute :image, Image
      attribute :in_stock, Boolean
      attribute :manage_stock, Boolean
      attribute :regular_price, Decimal
      attribute :sale_price, Decimal
      attribute :sku
      attribute :stock_quantity, Integer
      attribute :wc_attributes, Array
      attribute :weight

      # Read Only
      attribute :backordered       , Boolean , writer: :private
      attribute :backorders_allowed, Boolean , writer: :private
      attribute :date_created      , DateTime, writer: :private
      attribute :date_modified     , DateTime, writer: :private
      attribute :date_on_sale_from , DateTime , writer: :private
      attribute :date_on_sale_to   , DateTime , writer: :private
      attribute :dimensions        , Dimensions , writer: :private
      attribute :download_expiry   , Integer , writer: :private
      attribute :download_limit    , Integer , writer: :private
      attribute :downloadable      , Boolean , writer: :private
      attribute :downloads         , Array , writer: :private
      attribute :on_sale           , Boolean , writer: :private
      attribute :permalink         , String  , writer: :private
      attribute :price             , Decimal , writer: :private
      attribute :product_id        , Integer , writer: :private
      attribute :purchasable       , Boolean , writer: :private
      attribute :shipping_class    , String  , writer: :private
      attribute :tax_class         , String  , writer: :private
      attribute :tax_status        , String  , writer: :private
      attribute :virtual           , Boolean , writer: :private
      attribute :visible           , Boolean , writer: :private

      has_one :product, class_name: "Product", resource_uri: '/products'
    end
  end
end
