module WoocommerceAPI
  class Meta < Resource
    attribute :timezone
    attribute :currency
    attribute :currency_format
    attribute :currency_position
    attribute :price_num_decimals, Integer
    attribute :thousand_separator
    attribute :decimal_separator
    attribute :tax_included, Boolean
    attribute :weight_unit
    attribute :dimension_unit
    attribute :ssl_enabled, Boolean
    attribute :permalinks_enabled, Boolean
    attribute :links, Hash
  end
end
