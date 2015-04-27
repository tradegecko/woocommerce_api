module WoocommerceAPI
  class Store < Resource
    attribute :description
    attribute :meta, Meta
    attribute :name
    attribute :routes, Array[Route]
    attribute :URL
    attribute :wc_version
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

    def self.details
      extract_resource(http_request(:get, "/"))
    end
  end
end

