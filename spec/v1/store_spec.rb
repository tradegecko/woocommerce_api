require 'spec_helper'
shared_examples_for "a woocommerce store details" do |options|
  subject { described_class.details }

  it "fetchs store details" do
    expect(subject.namespace).to eq("wc/v1")
  end

  it "fetches routes" do
    endpoints = subject.routes.keys
    expect(endpoints).to include "/wc/v1/products"
    expect(endpoints).to include "/wc/v1/orders"
    expect(endpoints).to include "/wc/v1/webhooks"
    expect(endpoints).to include "/wc/v1/customers"
  end
end

describe WoocommerceAPI::Store do
  include_context "woocommerce_api_services", version: 'v1', use_cassette: 'v1/store_v1' do
    it_behaves_like "a woocommerce store details", version: 'v1'
  end
end
