module WoocommerceAPI
  module V3
    class FeeLine < Resource
      attribute :id, Integer
      attribute :title
      attribute :taxable, Boolean
      attribute :tax_class
      attribute :total, Decimal
      attribute :total_tax, Decimal

      alias_attribute :name, :title

      def meta_data
        []
      end
    end
  end
end
