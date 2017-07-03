require 'spec_helper'

describe Teewt::Middleware::CheckConfiguration do
  include_context 'spec'

  describe '.call' do
    it 'raises SystemExit with no configuration' do
      # Delete the temp configuration file.
      File.delete(project_path + '/tmp/teewt')

      expect{ described_class.new(app).call(env) }.to raise_error(SystemExit).and output("You must run `teewt authorize` in order to connect to Twitter\n").to_stdout
    end
  end
end
