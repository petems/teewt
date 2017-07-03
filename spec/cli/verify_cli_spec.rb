require 'spec_helper'

describe Teewt::CLI do
  include_context 'spec'

  describe 'verify' do
    it 'returns confirmation text when verify passes' do
      VCR.use_cassette 'cli/verify/successful' do
        expect{ cli.verify }.to output("Authentication with Twitter was successful.\n").to_stdout
        expect(a_request(:get, 'https://api.twitter.com/1.1/account/verify_credentials.json')).to have_been_made
      end
    end

    it 'returns error text when verify fails' do
      VCR.use_cassette 'cli/verify/failure' do
        expect{ cli.verify }.to output("Authentication with Twitter failed at an early stage\nError was: Bad Authentication data.\n").to_stdout.and raise_error(SystemExit)
        expect(a_request(:get, 'https://api.twitter.com/1.1/account/verify_credentials.json')).to have_been_made
      end
    end

  end
end
