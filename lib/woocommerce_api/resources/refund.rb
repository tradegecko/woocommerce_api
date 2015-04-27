require "woocommerce_api/resources/line_item"

module WoocommerceAPI
  class OrderRefund < Resource
    attribute :id
    attribute :reason
    attribute :amount, Decimal
    attribute :line_items, Array[LineItem]

    # Read Only
    attribute :created_at, DateTime
  end
end
