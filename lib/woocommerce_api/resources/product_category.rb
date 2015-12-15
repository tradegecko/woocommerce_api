module WoocommerceAPI
  class ProductCategory < Resource
    attribute :id, Integer
    attribute :name
    attribute :slug
    attribute :parent, Integer
    attribute :description
    attribute :display
    attribute :image
    attribute :count, Integer

    def self.collection_name
      'products/categories'
    end
  end
end
