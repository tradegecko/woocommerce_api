module WoocommerceAPI
  module V3
    class ProductReview < Resource
      attribute :id, Integer
      attribute :review
      attribute :rating, Integer
      attribute :reviewer_name
      attribute :reviewer_email
      attribute :verified, Boolean

      # Read Only
      alias_attribute :date_created, :created_at

      attribute :created_at, DateTime, writer: :private
    end
  end
end
