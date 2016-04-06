require 'spec_helper'

describe WoocommerceAPI::Product do
  include_context "woocommerce_api_services", use_cassette: 'variable_products'

  let(:variable_product) do
    WoocommerceAPI::Product.find 4737
  end

  context "when do variaiton CRUD" do
    describe "#create" do
      let(:new_variation) do
        WoocommerceAPI::Product.new(regular_price: 19.99)
      end

      it "creates new variation" do
        variations_size = variable_product.variations.size
        variable_product.variations << new_variation
        product = variable_product.save
        expect(product.variations.all?{|v| v.id.present? }).to be_truthy
      end
    end

    describe "#update" do
      let(:variation) do
        variable_product.variations.last
      end
      it "updates attibutes" do
        variation.update_attributes(regular_price: 199.9, managing_stock: true, stock_quantity: 1000)
        WoocommerceAPI::Product.find(variation.id).tap do |v|
          expect(v.regular_price).to eq 199.9
          expect(v.stock_quantity).to eq 1000
        end
      end
    end

    describe "#destroy" do
      it "destroys a variation" do
        variations_size = variable_product.variations.size
        variable_product.variations.last.destroy(force: true)
        variable_product.reload
        expect(variable_product.variations.size).to eq (variations_size - 1)
      end
    end
  end
end
