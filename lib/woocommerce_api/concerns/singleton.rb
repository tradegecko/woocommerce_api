module WoocommerceAPI
  module Singleton
    module ClassMethods
      attr_writer :singleton_name, :collection_name

      def singleton_name
        @singleton_name ||= model_name.element
      end

      def collection_name
        @collection_name ||= model_name.element.pluralize
      end

      def collection_path(prefix_options='', param_options=nil)
        "#{prefix_options}/#{collection_name}#{string_query(param_options)}"
      end

      def count_path(param_options=nil)
        "/#{collection_name}/count#{string_query(param_options)}"
      end

      def string_query(param_options)
        "?#{converted_params(param_options).to_query}" unless param_options.blank?
      end

      def all(params={})
        uri = params[:resource_uri].presence || collection_path(params[:prefix_options], params)
        resources = http_request(:get, uri)
        extract_resources(resources)
      end

      def count(params={})
        if legacy_api?
          response = http_request(:get, count_path(params))
          response['count'].to_i
        else
          headers(params).fetch('x-wp-total').to_i
        end
      end
      alias_method :size, :count

      def headers(params={})
        params.merge!({page: 1, per_page: 1})
        http_request(:get, collection_path(params[:prefix_options], converted_params(params)), header_request: true)
      end

      def find(id)
        return unless id.present?
        resource = http_request(:get, "#{collection_path}/#{id}")
        self.extract_resource(resource)
      end

      def create(attributes)
        self.new(attributes).create
      end

      def extract_resources(resources)
        if legacy_api?
          resources[collection_name]
        else
          resources
        end.collect { |r| self.new(r) }
      end

      def extract_resource(resource)
        if legacy_api?
          self.new(resource[singleton_name])
        else
          self.new(resource)
        end
      end
    end

    module InstanceMethods
      def singleton_name
        self.class.singleton_name
      end

      def collection_name
        self.class.collection_name
      end

      def collection_path(prefix_options='', query_options=nil)
        self.class.collection_path(prefix_options, query_options)
      end

      def save(options={})
        return unless valid?
        method = persisted? ? :put : :post
        resource = self.class.http_request(method, self.to_path, body: self.as_json(options).to_json)
        self.class.extract_resource(resource)
      end
      alias_method :create, :save

      def destroy(params={})
        self.class.http_request(:delete, "#{self.to_path}#{self.class.string_query(params)}")
      end

      def persisted?
        !!id
      end

      def reload
        return unless persisted?
        self.load(self.class.find(self.id).model.attributes)
      end

      def to_path
        "#{collection_path}#{"/#{id}" if id}"
      end

      def as_json(options={})
        self.model.as_json(options)
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
