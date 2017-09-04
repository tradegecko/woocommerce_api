require "woocommerce_api/resources/v2/address"
require "woocommerce_api/resources/v2/customer"
require "woocommerce_api/resources/v2/fee_line"
require "woocommerce_api/resources/v2/shipping_line"
require "woocommerce_api/resources/v2/coupon_line"
require "woocommerce_api/resources/v2/tax_line"

module WoocommerceAPI
  module V2
    class Order < Resource
      attribute :id, Integer
      attribute :status
      attribute :set_paid, Boolean

      attribute :billing                   , Address            , writer: :private
      attribute :cart_hash                 , String             , writer: :private
      attribute :cart_tax                  , Decimal            , writer: :private
      attribute :coupon_lines              , Array[CouponLine]  , writer: :private
      attribute :created_via               , String             , writer: :private
      attribute :currency                  , String             , writer: :private
      attribute :customer_id               , Integer            , writer: :private
      attribute :customer_ip_address       , String             , writer: :private
      attribute :customer_note             , String             , writer: :private
      attribute :customer_user_agent       , String             , writer: :private
      attribute :date_completed            , DateTime           , writer: :private
      attribute :date_created              , DateTime           , writer: :private
      attribute :date_modified             , DateTime           , writer: :private
      attribute :date_paid                 , DateTime           , writer: :private
      attribute :discount_tax              , Decimal            , writer: :private
      attribute :discount_total            , Decimal            , writer: :private
      attribute :fee_lines                 , Array[FeeLine]     , writer: :private
      attribute :line_items                , Array[LineItem]    , writer: :private
      attribute :number                    , String             , writer: :private
      attribute :order_key                 , String             , writer: :private
      attribute :parent_id                 , Integer            , writer: :private
      attribute :payment_method            , String             , writer: :private
      attribute :payment_method_title      , String             , writer: :private
      attribute :prices_include_tax        , Boolean            , writer: :private
      attribute :refunds                   , Array[OrderRefund] , writer: :private
      attribute :shipping                  , Address            , writer: :private
      attribute :shipping_lines            , Array[ShippingLine], writer: :private
      attribute :shipping_tax              , Decimal            , writer: :private
      attribute :shipping_total            , Decimal            , writer: :private
      attribute :subtotal                  , Decimal            , writer: :private
      attribute :subtotal_tax              , Decimal            , writer: :private
      attribute :tax_lines                 , Array[TaxLine]     , writer: :private
      attribute :total                     , Decimal            , writer: :private
      attribute :total_discount            , Decimal            , writer: :private
      attribute :total_shipping            , Decimal            , writer: :private
      attribute :total_tax                 , Decimal            , writer: :private
      attribute :transaction_id            , String             , writer: :private
      attribute :version                   , String             , writer: :private

      def order_notes
        WoocommerceAPI::OrderNote.all(self.id)
      end

      def paid
        self.date_paid.present?
      end

      def customer
        WoocommerceAPI::Customer.find(self.customer_id)
      end
    end
  end
end
