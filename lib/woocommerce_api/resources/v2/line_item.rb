require "woocommerce_api/resources/meta_datum"
module WoocommerceAPI
  module V2
    class LineItem < Resource
      attribute :id          , Integer
      attribute :product_id  , Integer
      attribute :variation_id, Integer
      attribute :quantity    , Integer
      attribute :subtotal    , Decimal
      attribute :subtotal_tax, Decimal
      attribute :total       , Decimal
      attribute :total_tax   , Decimal

      # Read Only
      attribute :sku       , String          , writer: :private
      attribute :name      , String          , writer: :private
      attribute :price     , Decimal         , writer: :private
      attribute :tax_class , String          , writer: :private
      attribute :meta_data , Array[MetaDatum], writer: :private

      # Write Only
      attribute :variations, Array[Hash]
    end
  end
end
