require 'spec_helper'

describe Teewt::Configuration do
  include_context 'spec'

  let(:tmp_path) { project_path + '/tmp/teewt' }

  after do
    # Clean up the temp file.
    File.delete(project_path + '/tmp/teewt') if File.exist?(project_path + '/tmp/teewt')
  end

  it 'is a singleton' do
    expect(described_class).to be_a Class
    expect do
      described_class.new
    end.to raise_error(NoMethodError, %r{private method `new' called})
  end

  it 'has a data attribute' do
    config = described_class.instance
    expect(config.data).to be
  end

  describe 'the file' do
    let(:consumer_key)        { 'consumerkey1'}
    let(:consumer_secret)     { 'consumersecret1'}
    let(:access_token)        { 'accesstoken1'}
    let(:access_token_secret) { 'accesstokensecret1'}

    let(:config) { described_class.instance }

    before do
      # Create a temporary file
      config.create_config_file(consumer_key, consumer_secret, access_token, access_token_secret)
    end

    it 'can be created' do
      expect(File.exist?(tmp_path)).to be_truthy
    end

    it 'can be loaded' do
      data = config.load_config_file
      expect(data).not_to be_nil
    end

    describe 'the file format' do
      let(:data) { YAML.load_file(tmp_path) }

      it 'has authentication at the top level' do
        expect(data).to have_key('authentication')
      end

      it 'has an consumer_key' do
        auth = data['authentication']
        expect(auth).to have_key('consumer_key')
        expect(auth['consumer_key']).to eql('consumerkey1')
      end

      it 'has an access_token' do
        auth = data['authentication']
        expect(auth).to have_key('access_token')
        expect(auth['access_token']).to eql('accesstoken1')
      end

      it 'has an consumer_secret token' do
        auth = data['authentication']
        expect(auth).to have_key('consumer_secret')
        expect(auth['consumer_secret']).to eql('consumersecret1')
      end

      it 'has an access_token token' do
        auth = data['authentication']
        expect(auth).to have_key('access_token')
        expect(auth['access_token']).to eql('accesstoken1')
      end

      it 'has an access_token_secret token' do
        auth = data['authentication']
        expect(auth).to have_key('access_token_secret')
        expect(auth['access_token_secret']).to eql('accesstokensecret1')
      end


    end
  end

end
