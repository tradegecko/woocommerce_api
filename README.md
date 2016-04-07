# Ruby Cleint for Woocommerce api 

[![Build Status](https://semaphoreci.com/api/v1/tradegecko/woocommerce_api/branches/fix-variations/badge.svg)](https://semaphoreci.com/tradegecko/woocommerce_api)
## Installation
```ruby
gem "woocommerce_api", github: "tradegecko/woocommerce_api"
```
```ruby
require "woocommerce_api"
```

## Initialize authorize access

```ruby
# Through https
WoocommerceAPI::Client.new(
  consumer_key: "ck_1234", 
  consumer_secret: "cs_1234", 
  store_url: "https://example.com")

# Through https but sending consumer_key and consumer_secret as query string
WoocommerceAPI::Client.new(
  consumer_key: "ck_1234", 
  consumer_secret: "cs_1234", 
  store_url: "https://example.com", 
  mode: :query_https)

# Through http (Oauth) 
WoocommerceAPI::Client.new(
  consumer_key: "ck_1234", 
  consumer_secret: "cs_1234", 
  store_url: "https://example.com", 
  mode: :oauth_http)
```

## Calling API
### Collection endpoints
returns a collection of the resource, size of collection limited by a configuration in Woocommerce setting (10 by default)
```ruby
WoocommerceAPI::Product.all
=> [collection of products]
```
collection with parameters, check more http://woothemes.github.io/woocommerce-rest-api-docs/#parameters 
```ruby
WoocommerceAPI::Product.all(filter: { limit: 50 })
WoocommerceAPI::Order.all(filter: { status: "complete", created_at_min: "2015-11-01" })
```
### Count 
```ruby
WoocommerceAPI::Product.count
WoocommerceAPI::Order.count(filter: { status: "commplete" })
```
### Finding a resource
```ruby 
WoocommerceAPI::Product.find(1) 
WoocommerceAPI::Order.find(1)
```
### Update a resource
```ruby
product = WoocommerceAPI::Product.find(1) 
product.update_attributes(regular_price: 100, managing_stock: true)
# or
product.regular_price = 100
product.managing_stock = true
product.save
```
### Destroy a resource 
```ruby
product.destroy # Soft delete a product (move to trash)
product.destroy(force: true) # Permanently delete a product
```

## Debugging 
We are using HTTParty, then...
```ruby
WoocommerceAPI::OauthClient.debug_output $stdout
WoocommerceAPI::Client.debug_output $stdout
```
