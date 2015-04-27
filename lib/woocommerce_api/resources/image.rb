module WoocommerceAPI
  class Image < Resource
    attribute :id, Integer
    attribute :src
    attribute :position, Integer

    # Read Only
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
    attribute :title
    attribute :alt
  end
end
