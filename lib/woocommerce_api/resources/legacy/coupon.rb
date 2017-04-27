module WoocommerceAPI
  module V3
    class Coupon < Resource
      attribute :id, Integer
      attribute :amount, Decimal
      attribute :code
      attribute :customer_emails, Array
      attribute :description
      attribute :enable_free_shipping, Boolean
      attribute :exclude_product_category_ids, Array
      attribute :exclude_product_ids, Array
      attribute :exclude_sale_items
      attribute :expiry_date, DateTime
      attribute :individual_use
      attribute :limit_usage_to_x_items, Integer
      attribute :maximum_amount, Decimal
      attribute :minimum_amount, Decimal
      attribute :product_category_ids, Array
      attribute :product_ids, Array
      attribute :type
      attribute :usage_limit
      attribute :usage_limit_per_user

      # Read Only
      alias_attribute :date_created, :created_at
      alias_attribute :date_modified, :updated_at

      attribute :created_at, DateTime, writer: :private
      attribute :updated_at, DateTime, writer: :private
      attribute :usage_count, Integer, writer: :private
    end
  end
end
