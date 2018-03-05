module WoocommerceAPI
  module V3
    class TaxLine < Resource
      attribute :id, Integer
      attribute :code
      attribute :compound, Boolean
      attribute :rate_id, Integer
      attribute :title
      attribute :total, Decimal
      def meta_data
        []
      end
    end
  end
end
