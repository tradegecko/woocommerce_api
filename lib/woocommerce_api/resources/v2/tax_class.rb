module WoocommerceAPI
  module V2
    class TaxClass < Resource
      attribute :slug, String, writer: :private
      attribute :name
    end
  end
end
