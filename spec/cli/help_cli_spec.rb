require 'spec_helper'

describe Teewt::CLI do
  include_context 'spec'

  describe 'help' do
    it 'shows a help message' do
      expect { (cli.help) }.to output(/Commands:/).to_stdout
      expect { (cli.help) }.to output(/To learn more or to contribute, please see github.com\/petems\/teewt/).to_stdout
    end

    it 'shows a help message for specific commands' do
      expect { (cli.help 'verify') }.to output(/Usage:/).to_stdout
      expect { (cli.help 'verify') }.to output(/This tests that your credentials created by the `authorize` command that are stored in ~\/.teewt are correct/).to_stdout
    end
  end
end
