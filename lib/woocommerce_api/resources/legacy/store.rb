require "woocommerce_api/resources/legacy/meta"

module WoocommerceAPI
  module V3
    class Store < Resource
      attribute :description
      attribute :meta, Meta
      attribute :name
      attribute :URL
      attribute :wc_version
      attribute :routes, Hash
      delegate :timezone,
               :currency,
               :currency_format,
               :currency_position,
               :price_num_decimals,
               :thousand_separator,
               :decimal_separator,
               :tax_included,
               :weight_unit,
               :dimension_unit,
               :ssl_enabled,
               :permalinks_enabled,
               :links,
               to: :meta
    end
  end
end
