require 'spec_helper'

describe Teewt::Middleware::CheckCredentials do
  include_context 'spec'

  describe '.call' do
    it 'raises SystemExit with no configuration' do
      VCR.use_cassette 'cli/verify/successful' do
        # Inject the client.
        env['twitter'] = twitter_client

        expect{ described_class.new(app).call(env) }.to output("Authentication with Twitter was successful.\n").to_stdout
        expect(a_request(:get, 'https://api.twitter.com/1.1/account/verify_credentials.json')).to have_been_made
      end
    end
  end
end
