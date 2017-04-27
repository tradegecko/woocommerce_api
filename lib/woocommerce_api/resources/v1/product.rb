module WoocommerceAPI
  module V1
    class Product < Resource
      def as_json(options={})
        product_attributes = super(options)
        if product_attributes[:wc_attributes] && !product_attributes[:wc_attributes].empty?
          product_attributes['attributes'] = product_attributes[:wc_attributes]
        end

        # Woocommerce does not support passing string of arrays for this attributes:
        # See http://woothemes.github.io/woocommerce-rest-api-docs/#products-properties
        product_attributes.delete('categories')
        product_attributes.delete('tags')
        product_attributes.delete('default_attributes')
        #product_attributes.delete('images') unless options[:images]

        product_attributes
      end

      attribute :id, Integer
      attribute :wc_attributes, Array
      attribute :backorders
      attribute :button_text
      attribute :catalog_visibility
      attribute :categories, Array
      attribute :cross_sell_ids, Array
      attribute :date_on_sale_from , DateTime
      attribute :date_on_sale_to , DateTime
      attribute :default_attributes , Hash
      attribute :description
      attribute :dimensions, Dimensions
      attribute :download_expiry, Integer
      attribute :download_limit, Integer
      attribute :download_type
      attribute :downloadable, Boolean
      attribute :downloads
      attribute :external_url
      attribute :featured, Boolean
      attribute :images, Array[Image] # Product's images
      attribute :in_stock, Boolean
      attribute :manage_stock, Boolean
      attribute :name
      attribute :parent_id
      attribute :purchase_note
      attribute :regular_price, Decimal
      attribute :reviews_allowed, Boolean
      attribute :sale_price, Decimal
      attribute :shipping_class
      attribute :short_description
      attribute :sku
      attribute :slug
      attribute :sold_individually, Boolean
      attribute :status
      attribute :stock_quantity, Integer
      attribute :tags, Array
      attribute :tax_class
      attribute :tax_status
      attribute :type
      attribute :upsell_ids, Array
      attribute :variations, Array[Product]
      attribute :virtual, Boolean
      attribute :weight

      # Read Only
      attribute :average_rating    , Decimal , writer: :private
      attribute :date_created      , DateTime, writer: :private
      attribute :date_modified     , DateTime, writer: :private
      attribute :backordered       , Boolean , writer: :private
      attribute :backorders_allowed, Boolean , writer: :private
      attribute :on_sale           , Boolean , writer: :private
      attribute :grouped_products  , Array   , writer: :private
      attribute :permalink         , String  , writer: :private
      attribute :price             , Decimal , writer: :private
      attribute :price_html        , String  , writer: :private
      attribute :purchasable       , Boolean , writer: :private
      attribute :rating_count      , Integer , writer: :private
      attribute :related_ids       , Array   , writer: :private
      attribute :shipping_class_id , Integer , writer: :private
      attribute :shipping_required , Boolean , writer: :private
      attribute :shipping_taxable  , Boolean , writer: :private
      attribute :total_sales       , Integer , writer: :private

      has_many :product_reviews, class_name: "ProductReview", resource_uri: '/reviews'
    end
  end
end
