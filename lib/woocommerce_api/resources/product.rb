require "woocommerce_api/resources/variation"

module WoocommerceAPI
  class Product < Resource

    def initialize(attributes={})
      # Rename restricted attributes
      if attributes['attributes']
        attributes['wc_attributes'] = attributes.delete('attributes')
      end
      super
    end

    def as_json(options=nil)
      wc_attributes = super(options)
      if attributes[:wc_attributes]
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

      wc_attributes
    end

    def save
      return unless valid?
      method = persisted? ? :put : :post
      body = self.as_json

      if method == :put
        body["product"].except!('attributes')
        body["product"]["variations"].each {|variation| variation.except!('attributes')}
      end

      resource = self.class.http_request(method, self.to_path, body: body.to_json)
      self.class.extract_resource(resource)
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
    attribute :enable_html_description, Boolean, default: true
    attribute :enable_html_short_description, Boolean, default: true

    has_many :product_reviews, class_name: "ProductReview", resource_uri: '/reviews'

    def self.sku(sku)
      extract_resource(http_request(:get, "/products/sku/#{sku}"))
    end
  end
end
