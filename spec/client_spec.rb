require 'spec_helper'

describe WoocommerceAPI::Client do
  include_context "woocommerce_api_services", use_cassette: 'client'

  context "oauth https mode" do
    it { expect(WoocommerceAPI::Product.count).to eq 201 }
  end

  context "oauth http mode" do
    let!(:woocommerce_params) do
      Thread.current["WoocommerceAPI"] = nil
      super().merge(mode: :oauth_http)
    end
    it { expect(WoocommerceAPI::Product.count).to eq 201 }
  end

  context "query https mode" do
    let!(:woocommerce_params) do
      Thread.current["WoocommerceAPI"] = nil
      super().merge(mode: :query_https)
    end
    it { expect(WoocommerceAPI::Product.count).to eq 201 }
  end

  context "be thread safety" do
    it "can handle multi-thread" do
      Thread.current["WoocommerceAPI"] = nil
      WoocommerceAPI::Client.new(consumer_key: 'ABC_KEY', consumer_secret: 'ABC_SECRET', store_url: 'https://api.woocommerce.com/ABC')

      Thread.new do
        WoocommerceAPI::Client.new(consumer_key: 'DEF_KEY', consumer_secret: 'DEF_SECRET', store_url: 'https://api.woocommerce.com/DEF', insecure_mode: true)
        expect(WoocommerceAPI::Client.default_options).to_not include :basic_auth
        expect(WoocommerceAPI::Client.default_options).to include base_uri: 'https://api.woocommerce.com/DEF/wc-api/v2'
        expect(WoocommerceAPI::Client.default_options).to include query: { consumer_key: 'DEF_KEY', consumer_secret: 'DEF_SECRET' }
      end

      expect(WoocommerceAPI::Client.default_options).to include basic_auth: { username: 'ABC_KEY', password: 'ABC_SECRET' }
      expect(WoocommerceAPI::Client.default_options).to include base_uri: 'https://api.woocommerce.com/ABC/wc-api/v2'
      expect(WoocommerceAPI::Client.default_options).to_not include :query
    end
  end
end
