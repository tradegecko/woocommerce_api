module WoocommerceAPI
  module V1
    class TaxClass < Resource
      attribute :slug, String, writer: :private
      attribute :name
    end
  end
end
