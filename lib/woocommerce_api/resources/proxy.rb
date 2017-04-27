class WoocommerceAPI::Variation < WoocommerceAPI::ResourceProxy
end

class WoocommerceAPI::Product < WoocommerceAPI::ResourceProxy
  def self.sku(sku)
    extract_resources(http_request(:get, "/products?sku=#{CGI.escape(sku)}"))
  end
end

class WoocommerceAPI::Dimensions < WoocommerceAPI::ResourceProxy
end

class WoocommerceAPI::Customer < WoocommerceAPI::ResourceProxy
end

class WoocommerceAPI::ProductReview < WoocommerceAPI::ResourceProxy
end

class WoocommerceAPI::Image < WoocommerceAPI::ResourceProxy
end

class WoocommerceAPI::Store < WoocommerceAPI::ResourceProxy
  def self.details
    extract_resource(http_request(:get, "/"))
  end
end

class WoocommerceAPI::Address < WoocommerceAPI::ResourceProxy
end

class WoocommerceAPI::Order < WoocommerceAPI::ResourceProxy
  def self.statuses
    response = http_request(:get, '/orders/statuses')
    response['order_statuses']
  end

  def customer
    model.customer
  end
end

class WoocommerceAPI::LineItem < WoocommerceAPI::ResourceProxy
end

class WoocommerceAPI::ShippingLine < WoocommerceAPI::ResourceProxy
end

class WoocommerceAPI::FeeLine < WoocommerceAPI::ResourceProxy
end

class WoocommerceAPI::CouponLine < WoocommerceAPI::ResourceProxy
  def coupon
    Coupon.find_by_code(code)
  end
end

class WoocommerceAPI::Coupon < WoocommerceAPI::ResourceProxy
  def self.find_by_code(code)
    return if code.blank?
    resource = http_request(:get, "#{collection_path}/code/#{code}")
    self.extract_resource(resource)
  end
end

class WoocommerceAPI::PaymentDetails < WoocommerceAPI::ResourceProxy
end

class WoocommerceAPI::OrderRefund < WoocommerceAPI::ResourceProxy
end

class WoocommerceAPI::OrderNote < WoocommerceAPI::ResourceProxy
  def self.collection_path(prefix_options='', param_options=nil)
    "/orders/#{@order_id}/notes/"
  end

  def self.all(order_id)
    return [] unless order_id
    @order_id = order_id
    super({})
  end

  def find(order_id, id)
    @order_id = order_id
    super(id)
  end

  def self.create(order_id, attributes)
    @order_id = order_id
    super(attributes)
  end
end

class WoocommerceAPI::Webhook < WoocommerceAPI::ResourceProxy
end

class WoocommerceAPI::WebhookDelivery < WoocommerceAPI::ResourceProxy
end
