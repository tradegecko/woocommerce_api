module WoocommerceAPI
  module V3
    class TaxRate < Resource
      attribute :id, Integer
      attribute :country
      attribute :state
      attribute :postcode
      attribute :city
      attribute :rate
      attribute :name
      attribute :priority, Integer
      attribute :compound, Boolean
      attribute :shipping, Boolean
      attribute :order, Integer
      attribute :tax_class

      def tax_class
        raw_params["class"]
      end
    end
  end
end
