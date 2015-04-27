module WoocommerceAPI
  class Customer < Resource
    attribute :id, Integer
    attribute :email
    attribute :first_name
    attribute :last_name
    attribute :username
    attribute :password
    attribute :last_order_id, Integer
    attribute :avatar_url
    attribute :billing_address, Address
    attribute :shipping_address, Address
    attribute :role

    # Read Only
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
    attribute :total_spent, Integer
    attribute :orders_count, Integer
    attribute :last_order_date
  end
end
