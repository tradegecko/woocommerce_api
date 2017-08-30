require "woocommerce_api/resources/legacy/image"
require "woocommerce_api/resources/legacy/dimensions"

module WoocommerceAPI
  module V3
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

        if wc_attributes['variation'].present?
          wc_attributes['variation'].delete('image') unless options[:images]
        else
          wc_attributes.delete('image') unless options[:images]
        end

        if attributes[:wc_attributes] && !attributes[:wc_attributes].empty?
          if wc_attributes['variation'].present?
            wc_attributes['variation']['attributes'] = attributes[:wc_attributes]
            wc_attributes['variation'].delete('wc_attributes')
          else
            wc_attributes['attributes'] = attributes[:wc_attributes]
            wc_attributes.delete('wc_attributes')
          end
        end

        wc_attributes
      end

      alias_attribute :date_created, :created_at
      alias_attribute :date_modified, :updated_at
      alias_attribute :manage_stock, :managing_stock

      # Managed attributes
      attribute :id, Integer
      attribute :backorders, Boolean
      attribute :image, Array[Image]
      attribute :in_stock, Boolean
      attribute :managing_stock, Boolean
      attribute :regular_price, Decimal
      attribute :sale_price, Decimal
      attribute :sku
      attribute :stock_quantity, Integer
      attribute :wc_attributes, Array
      attribute :weight

      # Unmanaged attributes
      attribute :backordered, Boolean, writer: :private
      attribute :backorders_allowed, Boolean, writer: :private
      attribute :created_at, DateTime, writer: :private
      attribute :dimensions, Dimensions, writer: :private
      attribute :download_expiry, Integer, writer: :private
      attribute :download_limit, Integer, writer: :private
      attribute :downloadable, Boolean, writer: :private
      attribute :downloads, Array, writer: :private
      attribute :on_sale, Boolean, writer: :private
      attribute :permalink, String, writer: :private
      attribute :price, Decimal, writer: :private
      attribute :purchaseable, Boolean, writer: :private
      attribute :sale_price_dates_from, DateTime, writer: :private
      attribute :sale_price_dates_to, DateTime, writer: :private
      attribute :shipping_class_id, Integer, writer: :private
      attribute :shipping_class, String, writer: :private
      attribute :tax_class, String, writer: :private
      attribute :tax_status, String, writer: :private
      attribute :taxable, Boolean, writer: :private
      attribute :updated_at, DateTime, writer: :private
      attribute :virtual, Boolean, writer: :private
      attribute :visible, Boolean, writer: :private
    end
  end
end
