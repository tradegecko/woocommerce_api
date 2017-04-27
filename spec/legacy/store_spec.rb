require 'spec_helper'
shared_examples_for "a woocommerce legacy store details" do |options|
  subject { described_class.details }

  it "fetchs store details" do
    expect(subject.description).to eq "TradeGecko WooCommerce Test"
    expect(subject.URL).to eq "http://wpcommercetest.wpengine.com"
    expect(subject.name).to eq "TradeGecko WooCommerce Test"
    expect(subject.wc_version).to eq "2.6.0"
  end

  it "fetchs store details" do
       expect(subject.meta.currency).to eq "SGD"
       expect(subject.meta.currency_format).to eq "&#36;"
       expect(subject.meta.currency_position).to eq "left"
       expect(subject.meta.decimal_separator).to eq "."
       expect(subject.meta.dimension_unit).to eq "cm"
       expect(subject.meta.generate_password).to be_falsey
       expect(subject.meta.links).to eq({"help"=>"https://woothemes.github.io/woocommerce-rest-api-docs/"})
       expect(subject.meta.permalinks_enabled).to be_truthy
       expect(subject.meta.price_num_decimals).to eq 2
       expect(subject.meta.ssl_enabled).to be_falsey
       expect(subject.meta.tax_included).to be_falsey
       expect(subject.meta.thousand_separator).to eq ","
       expect(subject.meta.timezone).to eq "Asia/Brunei"
       expect(subject.meta.weight_unit).to eq "kg"
  end

  it "fetches routes" do
    expect(subject.routes).to include({"/"=>{"supports"=>["HEAD", "GET"], "meta"=>{"self"=>"https://wpcommercetest.wpengine.com/wc-api/#{options[:version]}/"}}})
  end
end

describe WoocommerceAPI::Store do
  include_context "woocommerce_api_services", version: 'v3', use_cassette: 'legacy/store_v3' do
    it_behaves_like "a woocommerce legacy store details", version: 'v3'
  end
end

describe WoocommerceAPI::Store do
  include_context "woocommerce_api_services", version: 'v2', use_cassette: 'legacy/store_v2' do
    it_behaves_like "a woocommerce legacy store details", version: 'v2'
  end
end
