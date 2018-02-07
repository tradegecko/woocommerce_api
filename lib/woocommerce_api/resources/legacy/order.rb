require "woocommerce_api/resources/legacy/address"
require "woocommerce_api/resources/legacy/customer"
require "woocommerce_api/resources/legacy/fee_line"
require "woocommerce_api/resources/legacy/shipping_line"
require "woocommerce_api/resources/legacy/coupon_line"
require "woocommerce_api/resources/legacy/tax_line"
require "woocommerce_api/resources/legacy/payment_details"

module WoocommerceAPI
  module V3
    class Order < Resource
      attribute :id, Integer
      attribute :status

      # Read Only
      alias_attribute :date_created, :created_at
      alias_attribute :date_modified, :updated_at
      alias_attribute :date_completed, :completed_at
      alias_attribute :number, :order_number
      alias_attribute :discount_total, :total_discount
      alias_attribute :billing, :billing_address
      alias_attribute :shipping, :shipping_address
      alias_attribute :customer_note, :note

      attribute :billing_address           , Address            , writer: :private
      attribute :cart_tax                  , Decimal            , writer: :private
      attribute :completed_at              , DateTime           , writer: :private
      attribute :coupon_lines              , Array[CouponLine]  , writer: :private
      attribute :created_at                , DateTime           , writer: :private
      attribute :currency                  , String             , writer: :private
      attribute :customer                  , Customer           , writer: :private
      attribute :customer_id               , Integer            , writer: :private
      attribute :customer_ip               , String             , writer: :private
      attribute :customer_user_agent       , String             , writer: :private
      attribute :fee_lines                 , Array[FeeLine]     , writer: :private
      attribute :line_items                , Array[LineItem]    , writer: :private
      attribute :note                      , String             , writer: :private
      attribute :order_number              , Integer            , writer: :private
      attribute :payment_details           , PaymentDetails     , writer: :private
      attribute :shipping_address          , Address            , writer: :private
      attribute :shipping_lines            , Array[ShippingLine], writer: :private
      attribute :shipping_methods          , String             , writer: :private
      attribute :shipping_tax              , Decimal            , writer: :private
      attribute :subtotal                  , Decimal            , writer: :private
      attribute :tax_lines                 , Array[TaxLine]     , writer: :private
      attribute :total                     , Decimal            , writer: :private
      attribute :total_discount            , Decimal            , writer: :private
      attribute :total_line_items_quantity , Integer            , writer: :private
      attribute :total_shipping            , Decimal            , writer: :private
      attribute :total_tax                 , Decimal            , writer: :private
      attribute :updated_at                , DateTime           , writer: :private
      attribute :view_order_url            , String             , writer: :private

      has_many :refunds, class_name: 'OrderRefund', resource_uri: '/refunds'

      def order_notes
        WoocommerceAPI::OrderNote.all(self.id)
      end

      def paid
        self.payment_details.paid
      end

      def payment_method_title
        self.payment_details.method_title
      end

      def payment_method
        self.payment_details.method_id
      end

      def transaction_id
        self.payment_details.transaction_id
      end

      def shipment_details
        # NOOP
      end
    end
  end
end
