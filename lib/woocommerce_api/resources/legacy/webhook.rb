module WoocommerceAPI
  module V3
    class Webhook < Resource
      attribute :id, Integer
      attribute :name
      attribute :status
      attribute :topic
      attribute :delivery_url

      # Write Only
      attribute :secret    , String

      # Read Only
      alias_attribute :date_created, :created_at
      alias_attribute :date_modified, :updated_at

      attribute :created_at, DateTime     , writer: :private
      attribute :updated_at, DateTime     , writer: :private
      attribute :event     , String       , writer: :private
      attribute :hooks     , Array[String], writer: :private
      attribute :resource  , String       , writer: :private

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
