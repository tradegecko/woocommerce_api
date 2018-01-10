module WoocommerceAPI
  module AttributeSlicer
    def slice_by_sync_type(sync_type, attr_hash)
      case sync_type&.to_sym
      when :price
        attr_hash.slice(:id, :regular_price, :sale_price)
      when :stock_level
        attr_hash.slice(:id, :stock_quantity, :in_stock)
      when :price_and_stock_level
        attr_hash.slice(:id, :regular_price, :sale_price, :stock_quantity, :in_stock)
      else
        attr_hash
      end
    end
  end
end
