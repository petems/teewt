require 'spec_helper'

describe Teewt::CLI do
  include_context 'spec'

  describe 'version' do
    it 'shows the correct version' do
      cli.options = cli.options.merge(version: true)
      expect { (cli.version) }.to output(/Teewt #{Teewt::VERSION}/).to_stdout
    end
  end
end
