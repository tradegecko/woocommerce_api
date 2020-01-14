module WoocommerceAPI
  class Resource
    include Virtus.model
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON
    include WoocommerceAPI::Associations
    include WoocommerceAPI::Singleton
    include WoocommerceAPI::AttributeAssignment

    attr_reader :raw_params

    def initialize(params={})
      self.class.include_root_in_json = !!legacy_api?
      @raw_params = params.dup
      if params.is_a?(Hash) && params.has_key?('attributes')
        params['wc_attributes'] = params.delete('attributes')
      end
      load(params)
      super()
    end

    def legacy_api?
      self.class.legacy_api?
    end

    def self.legacy_api?
      !WoocommerceAPI::Client.default_options[:wordpress_api]
    end

    def load(params)
      params.each do |attr, value|
        self.send("#{attr}=", value) if self.respond_to?("#{attr}=", true)
      end if params
      self
    end

    # Every nested assocation. by default #as_json(root: false) could be applied
    def as_json(options={})
      attr_json = HashWithIndifferentAccess.new(super(options))

      if options.present? && options[:root]
        attr_json[singleton_name].each do |key, value|
          attr_json[singleton_name][key] = value.as_json(options.merge(root: false))
        end
      else
        attr_json.each do |key, value|
          attr_json[key] = value.as_json(options.merge(root: false))
        end
      end

      if legacy_api? && (keys = attr_json.keys).count == 1
        attr_json[keys.first].slice!(*managed_attributes)
      else
        attr_json.slice!(*managed_attributes)
      end

      attr_json
    end

    def managed_attributes
      allowed_writer_methods.map {|attr| attr.sub('=','')}
    end
  end # Resource
end
