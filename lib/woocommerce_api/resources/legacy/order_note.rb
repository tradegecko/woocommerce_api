module WoocommerceAPI
  module V3
    class OrderNote < Resource
      attribute :id, Integer
      attribute :customer_note, Boolean
      attribute :note

      # Read Only
      alias_attribute :date_created, :created_at

      attribute :created_at, DateTime, writer: :private
    end
  end
end
