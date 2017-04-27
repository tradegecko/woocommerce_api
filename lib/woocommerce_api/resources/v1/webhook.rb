module WoocommerceAPI
  module V1
    class Webhook < Resource
      attribute :id, Integer
      attribute :name
      attribute :status
      attribute :topic
      attribute :delivery_url

      # Write Only
      attribute :secret    , String

      # Read Only
      attribute :date_created , DateTime     , writer: :private
      attribute :date_modified, DateTime     , writer: :private
      attribute :event        , String       , writer: :private
      attribute :hooks        , Array[String], writer: :private
      attribute :resource     , String       , writer: :private

      has_many :deliveries, class_name: 'WebhookDelivery', resource_uri: '/deliveries'
    end
  end
end

# Available :topic
# coupon.created
# coupon.updated
# coupon.deleted
# customer.created
# customer.updated
# customer.deleted
# order.created
# order.updated
# order.deleted
# product.created
# product.updated
# product.deleted
