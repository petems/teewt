require 'spec_helper'

describe Teewt::Middleware::Base do
  include_context 'spec'

  let(:klass) { described_class }

  describe '.initialize' do
    it 'prints a clear line' do
      expect{ described_class.new(app).call(env) }.to output('').to_stdout
    end
  end
end
