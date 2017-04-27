module WoocommerceAPI
  module V1
    class ProductReview < Resource
      # Read Only
      attribute :id,             Integer,  writer: :private
      attribute :date_created,   DateTime, writer: :private
      attribute :review,         String,   writer: :private
      attribute :rating,         Integer,  writer: :private
      attribute :name,           String,   writer: :private
      attribute :email,          String,   writer: :private
      attribute :verified,       Boolean,  writer: :private
    end
  end
end
