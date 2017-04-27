module WoocommerceAPI
  module V3
    class Meta < Resource
      attribute :currency
      attribute :currency_format
      attribute :currency_position
      attribute :decimal_separator
      attribute :dimension_unit
      attribute :generate_password  , Boolean
      attribute :links              , Hash
      attribute :permalinks_enabled , Boolean
      attribute :price_num_decimals , Integer
      attribute :ssl_enabled        , Boolean
      attribute :tax_included       , Boolean
      attribute :thousand_separator
      attribute :timezone
      attribute :weight_unit
    end
  end
end
