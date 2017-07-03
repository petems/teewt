module Teewt
  module Middleware
    # Ask for user credentials from the command line, then write them out.
    class AskForCredentials < Base
      def call(env)
        say 'Note: You can get your Credentials from https://apps.twitter.com/app/new', :yellow
        consumer_key = ask 'Enter your consumer_key:'
        say
        consumer_secret = ask 'Enter your consumer secret:'
        say
        access_token = ask 'Enter your access token:'
        say
        access_token_secret = ask 'Enter your access token secret'
        say

        # Write the config file.
        env['config'].create_config_file(consumer_key, consumer_secret, access_token, access_token_secret)
        env['config'].reload!

        @app.call(env)
      end
    end
  end
end
