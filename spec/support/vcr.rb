# spec/support/vcr.rb
require 'vcr'
VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  # Let's you set default VCR mode with VCR=all for re-recording
  # episodes. :once is VCR default
  record_mode = ENV["VCR"] ? ENV["VCR"].to_sym : :once
  c.default_cassette_options = { :record => record_mode }

  c.filter_sensitive_data('<CONSUMER_KEY>')    { ENV['CONSUMER_KEY'] }
  c.filter_sensitive_data('<CONSUMER_SECRET>') { ENV['CONSUMER_SECRET'] }
  c.filter_sensitive_data('<USER_TOKEN>')      { ENV['ACCESS_TOKEN'] }
  c.filter_sensitive_data('<USER_SECRET>')     { ENV['ACCESS_TOKEN_SECRET'] }
end
