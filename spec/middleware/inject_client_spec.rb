require 'spec_helper'

describe Teewt::Middleware::InjectClient do
  include_context 'spec'

  let(:tmp_path) { project_path + '/tmp/teewt' }

  before do
    config = Teewt::Configuration.instance
    env['config'] = config
  end

  describe '.call' do
    it 'loads the client into the environment' do
      described_class.new(app).call(env)

      expect(env['twitter']).to be_a Twitter::REST::Client
    end

    it 'creates a client with values from config file' do
      expect(Twitter::REST::Client).to receive(:new)

      described_class.new(app).call(env)
    end
  end
end
