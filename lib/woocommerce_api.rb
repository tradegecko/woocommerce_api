require "rubygems"
require "active_support"
require "active_support/core_ext/hash"
require "active_model"
require "httparty"
require "virtus"

require "woocommerce_api/concerns/associations"
require "woocommerce_api/concerns/attribute_assignment"
require "woocommerce_api/concerns/singleton"
require "woocommerce_api/client"
require "woocommerce_api/oauth_client"
require "woocommerce_api/resource"
require "woocommerce_api/version"
require "woocommerce_api/resources/address.rb"
require "woocommerce_api/resources/coupon.rb"
require "woocommerce_api/resources/coupon_line.rb"
require "woocommerce_api/resources/customer.rb"
require "woocommerce_api/resources/delivery.rb"
require "woocommerce_api/resources/dimensions.rb"
require "woocommerce_api/resources/fee_line.rb"
require "woocommerce_api/resources/image.rb"
require "woocommerce_api/resources/line_item.rb"
require "woocommerce_api/resources/meta.rb"
require "woocommerce_api/resources/order.rb"
require "woocommerce_api/resources/order_note.rb"
require "woocommerce_api/resources/payment_details.rb"
require "woocommerce_api/resources/product.rb"
require "woocommerce_api/resources/product_attribute.rb"
require "woocommerce_api/resources/product_category.rb"
require "woocommerce_api/resources/product_review.rb"
require "woocommerce_api/resources/refund.rb"
require "woocommerce_api/resources/shipping_line.rb"
require "woocommerce_api/resources/store.rb"
require "woocommerce_api/resources/tax_line.rb"
require "woocommerce_api/resources/variation.rb"
require "woocommerce_api/resources/webhook.rb"
