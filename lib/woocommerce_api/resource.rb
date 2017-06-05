module WoocommerceAPI
  class Resource
    include Virtus.model
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON
    include WoocommerceAPI::Associations
    include WoocommerceAPI::AttributeAssignment

    def initialize(params={})
      self.class.include_root_in_json = !!legacy_api?
      if params['attributes']
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
  end # Resource
end
