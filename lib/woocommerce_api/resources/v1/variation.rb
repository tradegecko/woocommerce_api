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
        variant_attributes = super(options)
        if attributes[:wc_attributes] && !attributes[:wc_attributes].empty?
          variant_attributes['attributes'] = attributes[:wc_attributes]
        end

        variant_attributes.delete('image') unless options[:images]
        variant_attributes
      end

      attribute :id, Integer
      attribute :backorders
      attribute :image, Array[Image]
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
      attribute :purchasable       , Boolean , writer: :private
      attribute :shipping_class    , String  , writer: :private
      attribute :tax_class         , String  , writer: :private
      attribute :tax_status        , String  , writer: :private
      attribute :virtual           , Boolean , writer: :private
      attribute :visible           , Boolean , writer: :private
    end
  end
end
