require 'spec_helper'

describe WoocommerceAPI::Client do
  context "be thread safety" do

    it "can handle multi-thread" do
      WoocommerceAPI::Client.new(consumer_key: 'ABC_KEY', consumer_secret: 'ABC_SECRET', store_url: 'https://api.woocommerce.com/ABC')

      Thread.new do
        WoocommerceAPI::Client.new(consumer_key: 'DEF_KEY', consumer_secret: 'DEF_SECRET', store_url: 'https://api.woocommerce.com/DEF')
        expect(WoocommerceAPI::Client.default_options).to include basic_auth: { username: 'DEF_KEY', password: 'DEF_SECRET' }
        expect(WoocommerceAPI::Client.default_options).to include base_uri: 'https://api.woocommerce.com/DEF/wc-api/v2'
      end

      expect(WoocommerceAPI::Client.default_options).to include basic_auth: { username: 'ABC_KEY', password: 'ABC_SECRET' }
      expect(WoocommerceAPI::Client.default_options).to include base_uri: 'https://api.woocommerce.com/ABC/wc-api/v2'
    end
  end
end
