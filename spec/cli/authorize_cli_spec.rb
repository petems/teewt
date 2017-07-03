require 'spec_helper'

describe Teewt::CLI do
  include_context 'spec'

  let(:tmp_path) { project_path + '/tmp/teewt' }

  describe 'authorize' do
    before do
    end

    it 'asks the right questions and checks credentials' do
      VCR.use_cassette 'cli/authorize/successful' do
        expect($stdin).to receive(:gets).and_return(consumer_key)
        expect($stdin).to receive(:gets).and_return(consumer_secret)
        expect($stdin).to receive(:gets).and_return(access_token)
        expect($stdin).to receive(:gets).and_return(access_token_secret)

        authorize_success_stdout = <<-eos
Note: You can get your Credentials from https://apps.twitter.com/app/new
Enter your consumer_key:\x20
Enter your consumer secret:\x20
Enter your access token:\x20
Enter your access token secret\x20
Authentication with Twitter was successful.
eos

        expect { cli.authorize }.to output(authorize_success_stdout).to_stdout

        config = YAML.load_file(tmp_path)

        expect(config['authentication']['consumer_key']).to eq 'consumerkey'
        expect(config['authentication']['consumer_secret']).to eq 'consumersecret'
        expect(config['authentication']['access_token']).to eq 'accesstoken'
        expect(config['authentication']['access_token_secret']).to eq 'accesstokensecret'
      end
    end

  end
end
