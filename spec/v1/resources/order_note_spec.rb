require 'spec_helper'

describe WoocommerceAPI::OrderNote do
  it_behaves_like "a woocommerce resource"
  include_context "woocommerce_api_services", version: 'v1', use_cassette: 'v1/order_note'

  describe ".all" do
    it "returns order's notes collection" do
      expect(described_class.all(6149)).to be_kind_of Array
      expect(described_class.all(6149).sample).to be_kind_of described_class
    end
  end

  describe ".create" do
    let(:note_attributes) do
      { note: "Carrier: Blah Blah
               Tracking Number: BB1234567890" }
    end

    it "creates new note" do
      result = described_class.create(6149, note_attributes)
      expect(result).to be_kind_of described_class
      expect(result.customer_note).to be_falsey
      expect(result.id).to be_present
    end
  end

  context "from order object" do
    let(:order) { WoocommerceAPI::Order.find 6149}

    describe "#order_notes" do
      it "returns order's notes collection" do
        expect(order.order_notes).to be_kind_of Array
        expect(order.order_notes.sample).to be_kind_of described_class
      end
    end
  end
end
