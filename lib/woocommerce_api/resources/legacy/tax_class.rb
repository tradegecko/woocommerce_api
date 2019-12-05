module WoocommerceAPI
  module V3
    class TaxClass < Resource
      attribute :slug, String, writer: :private
      attribute :name
    end
  end
end
