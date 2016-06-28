require "woocommerce_api/resources/variation"

module WoocommerceAPI
  class Product < Resource

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
        if options && !options[:root]
          wc_attributes['attributes'] = attributes[:wc_attributes]
        else
          wc_attributes['product']['attributes'] = attributes[:wc_attributes]
        end
      end

      # Woocommerce does not support passing string of arrays for this attributes:
      # See http://woothemes.github.io/woocommerce-rest-api-docs/#products-properties
      wc_attributes['product'].delete('categories')
      wc_attributes['product'].delete('tags')
      wc_attributes['product'].delete('default_attributes')
      wc_attributes['product'].delete('images') unless options[:images]

      wc_attributes
    end

    attribute :id, Integer
    attribute :wc_attributes, Array
    attribute :catalog_visibility
    attribute :categories, Array
    attribute :cross_sell_ids, Array
    attribute :description
    attribute :dimensions, Dimensions
    attribute :download_expiry, Integer
    attribute :download_limit, Integer
    attribute :download_type
    attribute :downloadable, Boolean
    attribute :downloads
    attribute :featured, Boolean
    attribute :images, Array[Image]
    attribute :in_stock, Boolean
    attribute :managing_stock, Boolean
    attribute :parent
    attribute :parent_id
    attribute :purchase_note
    attribute :regular_price, Decimal
    attribute :reviews_allowed, Boolean
    attribute :sale_price, Decimal
    attribute :shipping_class
    attribute :short_description
    attribute :sku
    attribute :sold_individually, Boolean
    attribute :status
    attribute :stock_quantity, Integer
    attribute :tags, Array
    attribute :tax_class
    attribute :tax_status
    attribute :title
    attribute :total_sales, Integer
    attribute :type
    attribute :upsell_ids, Array
    attribute :variations, Array[Variation]
    attribute :virtual, Boolean
    attribute :weight
    attribute :enable_html_description      , Boolean , default: true
    attribute :enable_html_short_description, Boolean , default: true

    # Read Only
    attribute :created_at        , DateTime, writer: :private
    attribute :updated_at        , DateTime, writer: :private
    attribute :average_rating    , Decimal , writer: :private
    attribute :backordered       , Boolean , writer: :private
    attribute :backorders_allowed, Boolean , writer: :private
    attribute :featured_src      , String  , writer: :private
    attribute :on_sale           , Boolean , writer: :private
    attribute :permalink         , String  , writer: :private
    attribute :price             , Decimal , writer: :private
    attribute :price_html        , String  , writer: :private
    attribute :purchaseable      , Boolean , writer: :private
    attribute :rating_count      , Integer , writer: :private
    attribute :related_ids       , Array   , writer: :private
    attribute :shipping_class_id , Integer , writer: :private
    attribute :shipping_required , Boolean , writer: :private
    attribute :shipping_taxable  , Boolean , writer: :private
    attribute :taxable           , Boolean , writer: :private
    attribute :visible           , Boolean , writer: :private

    # Write Only
    attribute :default_attributes           , Hash
    attribute :sale_price_dates_from        , DateTime
    attribute :sale_price_dates_to          , DateTime
    attribute :backorders                   , Boolean
    attribute :product_url                  , String
    attribute :button_text                  , String

    has_many :product_reviews, class_name: "ProductReview", resource_uri: '/reviews'
    has_many :orders, class_name: "Order"

    def self.sku(sku)
      extract_resource(http_request(:get, "/products/sku/#{CGI.escape(sku)}"))
    end
  end
end
