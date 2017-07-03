require 'spec_helper'

shared_context 'spec' do
  # Default configuration and
  let(:config)             { Teewt::Configuration.instance }

  if ENV["VCR"]
    let(:consumer_key)        { ENV['CONSUMER_KEY'] }
    let(:consumer_secret)     { ENV['CONSUMER_SECRET'] }
    let(:access_token)        { ENV['ACCESS_TOKEN'] }
    let(:access_token_secret) { ENV['ACCESS_TOKEN_SECRET'] }
  else
    let(:consumer_key)        { 'consumerkey'}
    let(:consumer_secret)     { 'consumersecret'}
    let(:access_token)        { 'accesstoken'}
    let(:access_token_secret) { 'accesstokensecret'}
  end

  let(:twitter_client)     {
    Twitter::REST::Client.new do |config|
      config.consumer_key        = consumer_key
      config.consumer_secret     = consumer_secret
      config.access_token        = access_token
      config.access_token_secret = access_token_secret
    end
  }

  let(:app)                { ->(env) {} }
  let(:env)                { {} }
  let(:cli)                { Teewt::CLI.new }

  before do
    # Set a temprary project path and create fake config.
    config.create_config_file(consumer_key, consumer_secret, access_token, access_token_secret)
    config.reload!
  end

  after do
    # Delete the temporary configuration file if it exists.
    File.delete(project_path + '/tmp/teewt') if File.exist?(project_path + '/tmp/teewt')
  end
end
