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
require "woocommerce_api/resource"
Dir["./lib/woocommerce_api/resources/*.rb"].each { |f| require f }
