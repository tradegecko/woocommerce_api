module WoocommerceAPI
  module V1
    class OrderNote < Resource
      attribute :id, Integer
      attribute :customer_note, Boolean
      attribute :note

      # Read Only
      attribute :date_created, DateTime, writer: :private
    end
  end
end
