module WoocommerceAPI
  module Singleton
    module ClassMethods
      attr_writer :singleton_name, :collection_name
      DATE_KEYS = [:created_at_max, :created_at_min, :updated_at_min, :updated_at_max].freeze

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
        "?#{convert_date_params(param_options).to_query}" unless param_options.blank?
      end

      def convert_date_params(param_options)
        # Woocommerce requires all dates to be in RFC3339 format
        # in UTC timezone: YYYY-MM-DDTHH:MM:SSZ

        if param_options[:filter] && (param_options[:filter].keys & DATE_KEYS).present?
          date_params = param_options[:filter].slice(*DATE_KEYS)
          date_params.update(date_params) { |key, value| value.to_datetime.strftime("%FT%TZ") }
          param_options[:filter].merge!(date_params)
        end
        param_options
      end

      def all(params={})
        uri = params[:resource_uri].presence || collection_path(params[:prefix_options], params.slice(:filter, :page, :fields))
        resources = http_request(:get, uri)
        if !resources.nil? and resources.success?
          resources[collection_name].collect { |r| self.new(r) }
        else
          []
        end
      end

      def count(params={})
        response = http_request(:get, count_path(params.slice(:filter)))
        response['count'].to_i
      end
      alias_method :size, :count

      def find(id)
        return unless id.present?
        resource = http_request(:get, "#{collection_path}/#{id}")
        self.extract_resource(resource)
      end

      def create(attributes)
        self.new(attributes).create
      end

      def extract_resource(resource)
        self.new(resource[singleton_name])
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

      def save
        return unless valid?
        method = persisted? ? :put : :post
        resource = self.class.http_request(method, self.to_path, body: self.as_json.to_json)
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
        self.assign_attributes(self.class.find(self.id).attributes)
      end

      def to_path
        "/#{collection_name}#{"/#{id}" if id}"
      end

      # Every nested assocation. by default #as_json(root: false) could be applied
      def as_json(options=nil)
        attr_json = super(options)
        if options && options[:root]
          attr_json[singleton_name].each do |key, value|
            attr_json[singleton_name][key] = value.as_json(root: false)
          end
        else
          attr_json.each do |key, value|
            attr_json[key] = value.as_json(root: false)
          end
        end
        attr_json
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
