require 'spec_helper'

shared_examples 'parsable response' do
  let(:parsed_response) { WoocommerceAPI::ResourceProxy.parse_response(response) }
  it 'parses response body to json' do
    expect(parsed_response).to be_kind_of(Hash)
    expect(parsed_response).to eq({"count" => 123})
  end
end
describe WoocommerceAPI::ResourceProxy do
  describe '.parse_response' do
    context 'Parsing json body' do
      it_should_behave_like 'parsable response' do
        let(:response) { double(body: "{\"count\": 123}") }
      end
      it_should_behave_like 'parsable response' do
        let(:response) { double(body: "unrelated text {\"count\": 123} blah") }
      end
      it_should_behave_like 'parsable response' do
        let(:response) { double(body: "\uFEFF\uFEFF{\"count\": 123}") }
      end

      it 'raises error' do
        response = double(body: "something nonesense")
        expect{
          WoocommerceAPI::ResourceProxy.parse_response(response)
        }.to raise_error(JSON::ParserError)
      end
    end
  end
end
