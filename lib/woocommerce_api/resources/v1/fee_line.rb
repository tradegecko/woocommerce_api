module WoocommerceAPI
  module V1
    class FeeLine < Resource
      attribute :id, Integer
      attribute :name
      attribute :taxable, Boolean
      attribute :tax_class
      attribute :total, Decimal
      attribute :total_tax, Decimal

      def meta_data
        []
      end
    end
  end
end
