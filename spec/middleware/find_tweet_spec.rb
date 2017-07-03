require 'spec_helper'

describe Teewt::Middleware::FindTweet do
  include_context 'spec'

  describe '.call' do
    it 'raises SystemExit with no image data' do
      expect{ described_class.new(app).call(env) }.to raise_error(SystemExit).and output("Teewt attempted to find a tweet with no arguments.\nTry running `teewt  tweetid`\nFor more help run: `teewt help `\n").to_stdout
    end
  end
end
