require "woocommerce_api/resources/v1/variation"
require "woocommerce_api/resources/v1/variation"


module WoocommerceAPI
  module V1
    class Product < Resource
      include WoocommerceAPI::AttributeSlicer

      def as_json(options={})
        product_attributes = super(options)
        if attributes[:wc_attributes] && !attributes[:wc_attributes].empty?
          product_attributes['attributes'] = attributes[:wc_attributes]
          product_attributes.delete('wc_attributes')
        end
        product_attributes.delete('images') unless options[:images]
        if options[:description_sync_disabled]
          product_attributes.delete('description')
          product_attributes.delete('short_description')
        end
        product_attributes['backorders'] = nil if product_attributes['backorders'].blank?

        if sync_type = options[:sync_type]
          if product_attributes['variations'].present?
            product_attributes = product_attributes.slice(:id, :variations)
            variations = product_attributes['variations'].map do |attr_hash|
              slice_by_sync_type(sync_type, attr_hash)
            end
            product_attributes['variations'] = variations
          else
            product_attributes = slice_by_sync_type(sync_type, product_attributes)
          end
        end

        product_attributes
      end

      # Managed Attributes
      attribute :id, Integer
      attribute :backorders
      attribute :description
      attribute :images, Array[Image]
      attribute :in_stock, Boolean
      attribute :manage_stock, Boolean
      attribute :name
      attribute :regular_price, Decimal
      attribute :sale_price, Decimal
      attribute :sku
      attribute :stock_quantity, Integer
      attribute :type
      attribute :variations, Array[Variation]
      attribute :wc_attributes, Array
      attribute :weight

      # Unmanaged Attributes
      attribute :average_rating     , Decimal , writer: :private
      attribute :backordered        , Boolean , writer: :private
      attribute :backorders_allowed , Boolean , writer: :private
      attribute :button_text        , String  , writer: :private
      attribute :catalog_visibility , String  , writer: :private
      attribute :categories         , Array  , writer: :private
      attribute :cross_sell_ids     , Array  , writer: :private
      attribute :date_created       , DateTime, writer: :private
      attribute :date_modified      , DateTime, writer: :private
      attribute :date_on_sale_from  , DateTime  , writer: :private
      attribute :date_on_sale_to    , DateTime  , writer: :private
      attribute :default_attributes , Hash  , writer: :private
      attribute :dimensions         , Dimensions  , writer: :private
      attribute :download_expiry    , Integer  , writer: :private
      attribute :download_limit     , Integer  , writer: :private
      attribute :download_type      , String  , writer: :private
      attribute :downloadable       , Boolean  , writer: :private
      attribute :downloads          , String  , writer: :private
      attribute :external_url       , String  , writer: :private
      attribute :featured           , Boolean  , writer: :private
      attribute :grouped_products   , Array   , writer: :private
      attribute :on_sale            , Boolean , writer: :private
      attribute :parent_id          , String  , writer: :private
      attribute :permalink          , String  , writer: :private
      attribute :price              , Decimal , writer: :private
      attribute :price_html         , String  , writer: :private
      attribute :purchasable        , Boolean , writer: :private
      attribute :purchase_note      , String  , writer: :private
      attribute :rating_count       , Integer , writer: :private
      attribute :related_ids        , Array   , writer: :private
      attribute :reviews_allowed    , Boolean  , writer: :private
      attribute :shipping_class     , String  , writer: :private
      attribute :shipping_class_id  , Integer , writer: :private
      attribute :shipping_required  , Boolean , writer: :private
      attribute :shipping_taxable   , Boolean , writer: :private
      attribute :short_description  , String  , writer: :private
      attribute :slug               , String  , writer: :private
      attribute :sold_individually  , Boolean  , writer: :private
      attribute :status             , String  , writer: :private
      attribute :tags               , Array  , writer: :private
      attribute :tax_class          , String  , writer: :private
      attribute :tax_status         , String  , writer: :private
      attribute :total_sales        , Integer , writer: :private
      attribute :upsell_ids         , Array  , writer: :private
      attribute :virtual            , Boolean  , writer: :private

      has_many :product_reviews, class_name: "ProductReview", resource_uri: '/reviews'
    end
  end
end
