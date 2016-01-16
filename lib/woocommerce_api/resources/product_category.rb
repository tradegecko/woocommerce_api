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
      'product_categories'
    end

    def self.collection_path(prefix_options='', param_options=nil)
      "/products/categories#{string_query(param_options)}"
    end
  end
end
