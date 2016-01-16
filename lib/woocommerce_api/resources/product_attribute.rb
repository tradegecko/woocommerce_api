module WoocommerceAPI
  class ProductAttribute < Resource
    attribute :id, Integer
    attribute :name
    attribute :slug
    attribute :type
    attribute :order_by
    attribute :has_archives

    def self.collection_name
      'product_attributes'
    end

    def self.collection_path(prefix_options='', param_options=nil)
      "/products/attributes#{string_query(param_options)}"
    end
  end
end

