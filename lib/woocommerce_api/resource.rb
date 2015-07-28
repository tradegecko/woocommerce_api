module WoocommerceAPI
  class Resource
    include Virtus.model
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON
    include WoocommerceAPI::Singleton
    include WoocommerceAPI::Associations
    include WoocommerceAPI::AttributeAssignment
    self.include_root_in_json = true

    def self.http_request(verb, url, options={})
      response = WoocommerceAPI::Client.send(verb, url, options)
      if response.success?
        response
      else
        raise StandardError.new response
      end
    end
  end # Resource
end
