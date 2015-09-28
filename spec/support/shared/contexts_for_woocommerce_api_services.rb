require 'webmock'
require 'vcr'

shared_context "woocommerce_api_services" do |options|
  let(:woocommerce_params) do
    {
      consumer_key: "ck_1234567890abcdefghijklmnopqrstuv",
      consumer_secret: "cs_1234567890abcdefghijklmnopqrstuv",
      store_url: "https://wpcommercetest.wpengine.com"
    }
  end

  let(:woocommerce_api) { WoocommerceAPI::Client.new(woocommerce_params) }

  before { woocommerce_api }

  around(:each) do |example|
    VCR.use_cassette(options[:use_cassette],
      record: (options[:record] || :once),
      allow_playback_repeats: true,
      match_requests_on: [:method, VCR.request_matchers.uri_without_param(:oauth_timestamp, :oauth_nonce, :oauth_signature)]) do
        example.run
    end
  end
end
