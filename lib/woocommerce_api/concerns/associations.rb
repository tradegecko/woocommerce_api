module WoocommerceAPI
  module Associations
    module ClassMethods
      def has_many(association_name, options={})
        class_name = options[:class_name].presence || association_name.to_s.singularize.classify
        class_name.prepend("WoocommerceAPI::")

        define_method association_name do
          association_class = class_n ame.constantize
          resource_uri = self.to_path
          resource_uri.concat(options[:resource_uri].presence || association_class.collection_path)
          association_class.all(resource_uri: resource_uri)
        end
      end

      def has_one(association_name, options={})
        class_name = options[:class_name].presence || association_name.to_s.classify
        class_name.prepend("WoocommerceAPI::")

        define_method association_name do
          association_class = class_name.constantize
          resource_uri = "/#{self.class.collection_name}/#{self.id}"
          resource_uri.concat(options[:resource_uri].presence || "/#{association_class.resource_name}")
          resource = http_request(:get, resource_uri)
          self.extract_resource(resource)
        end
      end
    end

    def self.included(receiver)
      receiver.extend ClassMethods
    end
  end
end
