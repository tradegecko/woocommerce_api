module WoocommerceAPI
  class Resource
    include Virtus.model
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON
    include WoocommerceAPI::Singleton
    include WoocommerceAPI::Associations
    include WoocommerceAPI::AttributeAssignment

    def self.http_request(verb, url, options={})
      response = WoocommerceAPI::Client.send(verb, url, options)
      return if response.nil? and !response.success?
      response
    rescue => e
      puts e
    end
  end # Resource
end
