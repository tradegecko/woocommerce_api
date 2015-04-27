module WoocommerceAPI
  class OrderNote < Resource
    attribute :id, Integer
    attribute :customer_note, Boolean
    attribute :note

    # Read Only
    attribute :created_at, DateTime
  end
end
