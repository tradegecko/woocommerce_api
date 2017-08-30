require "woocommerce_api/resources/legacy/variation"

module WoocommerceAPI
  module V3
    class Product < Resource
      def as_json(options={})
        wc_attributes = super(options)

        if options.present? && !options[:root]
          wc_attributes.delete('images') unless options[:images]
          if options[:description_sync_disabled]
            wc_attributes.delete('description')
            wc_attributes.delete('short_description')
          end
        else
          wc_attributes['product'].delete('images') unless options[:images]
          if options[:description_sync_disabled]
            wc_attributes['product'].delete('description')
            wc_attributes['product'].delete('short_description')
          end
        end

        if attributes[:wc_attributes] && !attributes[:wc_attributes].empty?
          if options.present? && !options[:root]
            wc_attributes['attributes'] = attributes[:wc_attributes]
            wc_attributes.delete('wc_attributes')
          else
            wc_attributes['product']['attributes'] = attributes[:wc_attributes]
            wc_attributes['product'].delete('wc_attributes')
          end
        end

        wc_attributes
      end

      alias_attribute :date_created, :created_at
      alias_attribute :date_modified, :updated_at
      alias_attribute :name, :title
      alias_attribute :manage_stock, :managing_stock

      # Managed attributes
      attribute :id, Integer
      attribute :backorders, Boolean
      attribute :description
      attribute :images, Array[Image]
      attribute :in_stock, Boolean
      attribute :managing_stock, Boolean
      attribute :regular_price, Decimal
      attribute :sale_price, Decimal
      attribute :sku
      attribute :stock_quantity, Integer
      attribute :title
      attribute :type
      attribute :variations, Array[Variation]
      attribute :wc_attributes, Array
      attribute :weight

      # Unmanaged attributes
      attribute :catalog_visibility, String, writer: :private
      attribute :categories, Array, writer: :private
      attribute :cross_sell_ids, Array, writer: :private
      attribute :dimensions, Dimensions, writer: :private
      attribute :download_expiry, Integer, writer: :private
      attribute :download_limit, Integer, writer: :private
      attribute :download_type, String, writer: :private
      attribute :downloadable, Boolean, writer: :private
      attribute :downloads, String, writer: :private
      attribute :featured, Boolean, writer: :private
      attribute :parent, String, writer: :private
      attribute :parent_id, String, writer: :private
      attribute :purchase_note, String, writer: :private
      attribute :reviews_allowed, Boolean, writer: :private
      attribute :shipping_class, String, writer: :private
      attribute :short_description, String, writer: :private
      attribute :sold_individually, Boolean, writer: :private
      attribute :status, String  , writer: :private
      attribute :tags, Array, writer: :private
      attribute :tax_class, String  , writer: :private
      attribute :tax_status, String  , writer: :private
      attribute :total_sales, Integer, writer: :private
      attribute :upsell_ids, Array, writer: :private
      attribute :virtual, Boolean, writer: :private
      attribute :enable_html_description, Boolean, default: true, writer: :private
      attribute :enable_html_short_description, Boolean, default: true, writer: :private
      attribute :created_at, DateTime, writer: :private
      attribute :updated_at, DateTime, writer: :private
      attribute :average_rating, Decimal, writer: :private
      attribute :backordered, Boolean, writer: :private
      attribute :backorders_allowed, Boolean, writer: :private
      attribute :featured_src, String, writer: :private
      attribute :on_sale, Boolean, writer: :private
      attribute :permalink, String, writer: :private
      attribute :price, Decimal, writer: :private
      attribute :price_html, String, writer: :private
      attribute :purchaseable, Boolean, writer: :private
      attribute :rating_count, Integer, writer: :private
      attribute :related_ids, Array, writer: :private
      attribute :shipping_class_id, Integer , writer: :private
      attribute :shipping_required, Boolean , writer: :private
      attribute :shipping_taxable, Boolean , writer: :private
      attribute :taxable, Boolean , writer: :private
      attribute :visible, Boolean , writer: :private
      attribute :default_attributes, Hash, writer: :private
      attribute :sale_price_dates_from, DateTime, writer: :private
      attribute :sale_price_dates_to, DateTime, writer: :private
      attribute :product_url, String, writer: :private
      attribute :button_text, String, writer: :private

      has_many :product_reviews, class_name: "ProductReview", resource_uri: '/reviews'
      has_many :orders, class_name: "Order"
    end
  end
end
