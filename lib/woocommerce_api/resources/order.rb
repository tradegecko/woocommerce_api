require "woocommerce_api/resources/fee_line"
require "woocommerce_api/resources/shipping_line"
require "woocommerce_api/resources/tax_line"
require "woocommerce_api/resources/payment_details"

module WoocommerceAPI
  class Order < Resource
    attribute :id, Integer
    attribute :status
    attribute :order_number, Integer
    attribute :currency
    attribute :payment_details, PaymentDetails
    attribute :billing_address, Address
    attribute :shipping_address, Address
    attribute :note
    attribute :customer_id, Integer
    attribute :line_items, Array[LineItem]
    attribute :shipping_lines, Array[ShippingLine]
    attribute :fee_lines, Array[FeeLine]
    attribute :coupon_lines, Array[CouponLine]
    attribute :customer, Customer

    # Read Only
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
    attribute :completed_at, DateTime
    attribute :total, Decimal
    attribute :subtotal, Decimal
    attribute :total_line_items_quantity, Integer
    attribute :total_tax, Decimal
    attribute :total_shipping, Decimal
    attribute :cart_tax, Decimal
    attribute :shipping_tax, Decimal
    attribute :total_discount, Decimal
    attribute :shipping_methods
    attribute :customer_ip
    attribute :customer_user_agent
    attribute :view_order_url
    attribute :tax_lines, Array[TaxLine]

    has_many :order_notes, class_name: 'OrderNote', resource_uri: '/notes'
    has_many :order_refunds, class_name: 'OrderRefund', resource_uri: '/refunds'
  end
end
