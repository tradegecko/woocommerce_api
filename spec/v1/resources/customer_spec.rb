require 'spec_helper'

describe WoocommerceAPI::Customer do
  it_behaves_like "a woocommerce resource"
  include_context "woocommerce_api_services", version: 'v1', use_cassette: 'v1/customer'

  let(:customers) { described_class.all }
  let(:customer) { customers.first }

  it "responses collection of Customer" do
    expect(customers).to be_kind_of Array
  end

  it "is Customer" do
    expect(customer).to be_kind_of described_class
  end
end
