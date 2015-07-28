require 'spec_helper'


shared_examples_for "a woocommerce product CRUD" do
  let(:valid_attributes) do
    {
      title: "Premium Quality (TEST)",
      type: "simple",
      regular_price: "21.99",
      description: "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.",
      short_description: "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.",
      managing_stock: true,
      stock_quantity: 345,
      categories: [
        "Clothing",
        "T-shirts"
      ]
    }
  end

  let(:products) { WoocommerceAPI::Product.all }
  let(:product) { products.first }

  it "responses collection of product" do
    expect(products).to be_kind_of Array
  end

  it "is Product" do
    expect(product).to be_kind_of described_class
  end

  it "deletes a product" do
    expect(wc_product.destroy).to include({"message"=>"Deleted product"})
  end
end

describe WoocommerceAPI::Product do
  it_behaves_like "a woocommerce resource"

  context "when CRUD with standalone product" do
    include_context "woocommerce_api_services", use_cassette: 'product'#, record: :all
    it_behaves_like "a woocommerce product CRUD" do

      let(:wc_product) { described_class.create(valid_attributes) }

      it "creates a new product" do
        expect(wc_product.title).to eq "Premium Quality (TEST)"
        expect(wc_product.regular_price).to eq 21.99
        expect(wc_product.stock_quantity).to eq 345
      end

      it "updates attributes" do
        wc_product.update_attributes(title: "UpdatedTitle", regular_price: '34.77')
        wc_product.reload
        expect(wc_product.title).to eq "UpdatedTitle"
        expect(wc_product.regular_price).to eq 34.77
      end
    end
  end

  context "when included variations" do
    include_context "woocommerce_api_services", use_cassette: 'product_with_variants'#, record: :all
    it_behaves_like "a woocommerce product CRUD" do
      let(:valid_nested_attributes) do
        { type: 'variable',
          wc_attributes: [
            { name: 'Size', options: ['S', 'M'] }
          ],
          variations: [
            { regular_price: 123,
              managing_stock: true,
              stock_quantity: 321,
              wc_attributes: [{ name: 'Size', option: 'S' }]
            },
            { regular_price: 123,
              managing_stock: true,
              stock_quantity: 321,
              wc_attributes: [{ name: 'Size', option: 'M' }]
            }
          ]
        }
      end

      let(:wc_product) do
        described_class.create(valid_attributes.merge(valid_nested_attributes))
      end

      describe "expected attributes" do
        context "product" do
          it "product's attributes" do
            expect(wc_product.regular_price).to eq 0.0
            expect(wc_product.wc_attributes).to eq [{"name"=>"Size", "slug"=>"Size", "position"=>0, "visible"=>false, "variation"=>false, "options"=>["S", "M"]}]
          end
        end

        context "variations" do
          it "collection of variations" do
            expect(wc_product.variations.size).to eq 2
            wc_product.variations.each do |variation|
              expect(variation.regular_price).to eq 123
              expect(variation.stock_quantity).to eq 321
            end
          end
        end
      end
    end
  end
end
