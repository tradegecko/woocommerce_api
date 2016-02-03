module WoocommerceAPI
  class Image < Resource
    attribute :id, Integer
    attribute :src
    attribute :position, Integer

    # Read Only
    attribute :created_at, DateTime, writer: :private
    attribute :updated_at, DateTime, writer: :private
    attribute :title, String, writer: :private
    attribute :alt, String, writer: :private
  end
end
