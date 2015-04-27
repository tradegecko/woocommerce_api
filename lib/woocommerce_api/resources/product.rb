require "woocommerce_api/resources/variation"

module WoocommerceAPI
  class Product < Resource
    attribute :id, Integer
    attribute :custom_attributes
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

    # Read Only
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
    attribute :average_rating
    attribute :backordered, Boolean
    attribute :backorders_allowed, Boolean
    attribute :featured_src
    attribute :on_sale, Boolean
    attribute :permalink
    attribute :price, Decimal
    attribute :price_html
    attribute :purchaseable, Boolean
    attribute :rating_count, Integer
    attribute :related_ids, Array
    attribute :shipping_class_id, Integer
    attribute :shipping_required, Boolean
    attribute :shipping_taxable, Boolean
    attribute :taxable, Boolean
    attribute :visible, Boolean

    # Write Only
    attribute :default_attributes, Hash
    attribute :sale_price_dates_from, DateTime
    attribute :sale_price_dates_to, DateTime
    attribute :product_url
    attribute :button_text

    has_many :product_reviews, class_name: "ProductReview", resource_uri: '/reviews'
  end
end
