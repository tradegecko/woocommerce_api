require "woocommerce_api/resources/meta_datum"
module WoocommerceAPI
  module V2
    class FeeLine < Resource
      attribute :id, Integer
      attribute :name
      attribute :taxable, Boolean
      attribute :tax_class
      attribute :total, Decimal
      attribute :total_tax, Decimal
      attribute :meta_data, Array[MetaDatum], writer: :private
    end
  end
end
