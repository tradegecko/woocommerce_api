module WoocommerceAPI
  class ProductReview < Resource

    attribute :id, Integer
    attribute :review
    attribute :rating, Integer
    attribute :reviewer_name
    attribute :reviewer_email
    attribute :verified, Boolean

    # Read Only
    attribute :created_at, DateTime

  end
end
