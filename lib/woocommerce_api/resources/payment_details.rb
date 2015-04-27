module WoocommerceAPI
  class PaymentDetails < Resource
    attribute :method
    attribute :method_id, Integer
    attribute :method_title
    attribute :paid, Boolean
  end
end
