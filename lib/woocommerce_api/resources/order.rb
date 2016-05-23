require "woocommerce_api/resources/address"
require "woocommerce_api/resources/customer"
require "woocommerce_api/resources/fee_line"
require "woocommerce_api/resources/shipping_line"
require "woocommerce_api/resources/coupon_line"
require "woocommerce_api/resources/tax_line"
require "woocommerce_api/resources/payment_details"

module WoocommerceAPI
  class Order < Resource
    attribute :id, Integer
    attribute :billing_address  , Address
    attribute :coupon_lines     , Array[CouponLine]
    attribute :currency
    attribute :customer         , Customer
    attribute :customer_id      , Integer
    attribute :fee_lines        , Array[FeeLine]
    attribute :line_items       , Array[LineItem]
    attribute :note
    attribute :order_number     , Integer
    attribute :payment_details  , PaymentDetails
    attribute :shipping_address , Address
    attribute :shipping_lines   , Array[ShippingLine]
    attribute :status

    # Read Only
    attribute :created_at                , DateTime       , writer: :private
    attribute :updated_at                , DateTime       , writer: :private
    attribute :completed_at              , DateTime       , writer: :private
    attribute :total                     , Decimal        , writer: :private
    attribute :subtotal                  , Decimal        , writer: :private
    attribute :total_line_items_quantity , Integer        , writer: :private
    attribute :total_tax                 , Decimal        , writer: :private
    attribute :total_shipping            , Decimal        , writer: :private
    attribute :cart_tax                  , Decimal        , writer: :private
    attribute :shipping_tax              , Decimal        , writer: :private
    attribute :total_discount            , Decimal        , writer: :private
    attribute :shipping_methods          , String         , writer: :private
    attribute :customer_ip               , String         , writer: :private
    attribute :customer_user_agent       , String         , writer: :private
    attribute :view_order_url            , String         , writer: :private
    attribute :tax_lines                 , Array[TaxLine] , writer: :private

    has_many :order_refunds, class_name: 'OrderRefund', resource_uri: '/refunds'

    def order_notes
      OrderNote.all(self.id)
    end

    def self.statuses
      response = http_request(:get, '/orders/statuses')
      response['order_statuses']
    end
  end
end
