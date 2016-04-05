module WoocommerceAPI
  class Decimal < Virtus::Attribute
    def coerce(value)
      return 0.0 unless value.present?
      value.to_d
    end
  end
end
