require "woocommerce_api/resources/v2/line_item"

module WoocommerceAPI
  module V2
    class OrderRefund < Resource
      attribute :id
      attribute :reason
      attribute :amount, Decimal
      attribute :line_items, Array[LineItem]

      # Read Only
      attribute :date_created, DateTime, writer: :private
    end
  end
end
