require 'webmock'
require 'vcr'

shared_context "woocommerce_api_services" do |options|
  let(:woocommerce_api) do
    params = {
      consumer_key: "ck_1234567890abcdefghijklmnopqrstuv",
      consumer_secret: "cs_1234567890abcdefghijklmnopqrstuv",
      store_url: "https://wpcommercetest.wpengine.com"
    }
    WoocommerceAPI::Client.new(params)
  end

  before { woocommerce_api }

  around(:each) do |example|
    VCR.use_cassette(options[:use_cassette],
      record: (options[:record] || :once),
      allow_playback_repeats: true) do
      example.run
    end
  end
end
