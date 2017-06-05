require 'spec_helper'

describe WoocommerceAPI::Order do
  it_behaves_like "a woocommerce resource"
  include_context "woocommerce_api_services", version: 'v1', wordpress_api: true, use_cassette: 'v1/order'

  let(:valid_attributes) do
    {
      customer_note: "This is note",
      payment_details: {
        method_id: "bacs",
        method_title: "Direct Bank Transfer",
        paid: true
      },
      billing_address: {
        first_name: "John",
        last_name: "Doe",
        address_1: "969 Market",
        address_2: "",
        city: "San Francisco",
        state: "CA",
        postcode: "94103",
        country: "US",
        email: "john@example.com",
        phone: "(555) 555-5555"
      },
      shipping_address: {
        first_name: "John",
        last_name: "Doe",
        address_1: "969 Market",
        address_2: "",
        city: "San Francisco",
        state: "CA",
        postcode: "94103",
        country: "US"
      },
      customer_id: 2,
      line_items: [
        {
          product_id: 6512,
          quantity: 2
        }
      ],
      shipping_lines: [
        {
          method_id: "flat_rate",
          method_title: "Flat Rate",
          total: 10
        }
      ]
    }
  end
  let(:orders) { described_class.all }
  let(:order) { orders.first }
  let(:wc_order) { described_class.create(valid_attributes) }

  it "responses collection of Order" do
    expect(orders).to be_kind_of Array
  end

  it "is Order" do
    expect(order).to be_kind_of described_class
  end

  it "creates a new Order" do
    expect(wc_order).to be_kind_of described_class
    expect(wc_order.customer_id).to eq 2
    expect(wc_order.customer_note).to eq "This is note"
  end

  it "updates attributes" do
    wc_order.update_attributes(customer_id: 3, customer_note: "This new note")
    wc_order.reload
    expect(wc_order.customer_id).to eq 3
    expect(wc_order.customer_note).to eq "This new note"
  end

  it "deletes an Order" do
    expect(wc_order.destroy['id']).to eq(wc_order.id)
  end
end
