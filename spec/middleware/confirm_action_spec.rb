require 'spec_helper'

describe Teewt::Middleware::ConfirmAction do
  include_context 'spec'

  describe '.call' do
    it 'runs when yes' do
      expect($stdin).to receive(:gets).and_return('y')
      expect{ described_class.new(app).call(env) }.to output("Warning! Potentially destructive action. Please confirm [y/n]: ").to_stdout
    end

    it 'raises SystemExit when no' do
      expect($stdin).to receive(:gets).and_return('n')
      expect{ described_class.new(app).call(env) }.to raise_error(SystemExit).and output("Warning! Potentially destructive action. Please confirm [y/n]: Aborted due to user request.\n").to_stdout
    end
  end
end
