require 'spec_helper'

describe Teewt::CLI do
  include_context 'spec'

  describe 'config' do
    it 'shows the full config' do
      config_stdout_string = <<-eos
Current Config\x20
Path: #{Dir.pwd}/tmp/teewt
---
authentication:
  consumer_key: consumerkey
  consumer_secret: consumersecret
  access_token: accesstoken
  access_token_secret: accesstokensecret
eos

      expect { (cli.config) }.to output(config_stdout_string).to_stdout
    end

    it 'hides sensitive data if option given' do
      config_stdout_redacted_string = eq <<-eos
Current Config (Keys Redacted)
Path: #{Dir.pwd}/tmp/teewt
---
authentication:
  consumer_key:  [REDACTED]
  consumer_secret:  [REDACTED]
  access_token:  [REDACTED]
  access_token_secret:  [REDACTED]
      eos

      cli.options = cli.options.merge(hide: true)

      expect { (cli.config) }.to output(config_stdout_redacted_string).to_stdout
    end
  end
end
