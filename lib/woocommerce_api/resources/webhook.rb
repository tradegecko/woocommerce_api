module WoocommerceAPI
  class Webhook < Resource
    attribute :id, Integer
    attribute :name
    attribute :status
    attribute :topic
    attribute :delivery_url

    # Write Only
    attribute :secret

    # Read Only
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
    attribute :event
    attribute :hooks, Array
    attribute :resource

    has_many :deliveries, class_name: 'WebhookDelivery', resource_uri: '/deliveries'
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
