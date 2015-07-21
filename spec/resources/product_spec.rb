require 'spec_helper'

describe WoocommerceAPI::Product do
  it_behaves_like "a woocommerce resource"
  include_context "woocommerce_api_services", use_cassette: 'product'#, record: :all

  let(:valid_attributes) do
    {
      title: "Premium Quality (TEST)",
      type: "simple",
      regular_price: "21.99",
      description: "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.",
      short_description: "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.",
      categories: [
        "Clothing",
        "T-shirts"
      ],
      wc_attributes: [{name: 'test', options: ['option1', 'option2']}]
    }
  end

  let(:products) { WoocommerceAPI::Product.all }
  let(:product) { products.first }

  def wc_product
    @wc_product ||= described_class.create(valid_attributes)
  end

  it "responses collection of product" do
    expect(products).to be_kind_of Array
  end

  it "is Product" do
    expect(product).to be_kind_of described_class
  end

  it "creates a new product" do
    expect(wc_product).to be_kind_of described_class
    expect(wc_product.title).to eq "Premium Quality (TEST)"
    expect(wc_product.regular_price).to eq 21.99
    expect(wc_product.wc_attributes).to eq [{"name"=>"Test", "slug"=>"test", "position"=>0, "visible"=>false, "variation"=>false, "options"=>["option1", "option2"]}]
  end

  it "updates attributes" do
    wc_product.update_attributes(title: "UpdatedTitle", regular_price: '34.77')
    wc_product.reload
    expect(wc_product.title).to eq "UpdatedTitle"
    expect(wc_product.regular_price).to eq 34.77
  end

  it "deletes a product" do
    expect(wc_product.destroy).to include({"message"=>"Deleted product"})
  end
end
