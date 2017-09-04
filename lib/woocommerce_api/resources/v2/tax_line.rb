module WoocommerceAPI
  module V2
    class TaxLine < Resource
      attribute :id, Integer
      attribute :code
      attribute :compound, Boolean
      attribute :rate_id, Integer
      attribute :title
      attribute :total, Decimal
    end
  end
end
