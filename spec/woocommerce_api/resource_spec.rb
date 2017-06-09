require 'spec_helper'

describe WoocommerceAPI::Resource do
  context "include_root_in_json" do
    it "can handle multi-thread" do
      Thread.current["WoocommerceAPI"] = nil
      WoocommerceAPI::Client.new(consumer_key: 'ABC_KEY', consumer_secret: 'ABC_SECRET', store_url: 'https://api.woocommerce.com/ABC', wordpress_api: true)

      Thread.new do
        WoocommerceAPI::Client.new(consumer_key: 'DEF_KEY', consumer_secret: 'DEF_SECRET', store_url: 'https://api.woocommerce.com/DEF')
        expect(WoocommerceAPI::Resource.new.class.include_root_in_json).to be_truthy
      end

      Thread.new do
        WoocommerceAPI::Client.new(consumer_key: 'HIJ_KEY', consumer_secret: 'HIJ_SECRET', store_url: 'https://api.woocommerce.com/HIJ', wordpress_api: false)
        expect(WoocommerceAPI::Resource.new.class.include_root_in_json).to be_truthy
      end

      expect(WoocommerceAPI::Resource.new.class.include_root_in_json).to be_falsey
    end
  end
end
