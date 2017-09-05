module WoocommerceAPI
  module V2
    class PaymentGateway < Resource
      attribute :id
      attribute :description
      attribute :enabled, Boolean
      attribute :order, Integer
      attribute :title
      attribute :method_title
      attribute :method_description
      attribute :settings, Hash
    end
  end
end
