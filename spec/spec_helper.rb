require 'bundler/setup'
require 'woocommerce_api'
require 'rspec'
require 'pry'

Bundler.setup

Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # some (optional) config here
end

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end
