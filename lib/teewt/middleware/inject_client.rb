require 'twitter'

module Teewt
  module Middleware
    # Inject the digital ocean client into the environment
    class InjectClient < Base
      def call(env)
        # Sets the digital ocean client into the environment for use
        # later.
        @consumer_key         = env['config'].consumer_key
        @consumer_secret      = env['config'].consumer_secret
        @access_token         = env['config'].access_token
        @access_token_secret  = env['config'].access_token_secret

        env['twitter'] = Twitter::REST::Client.new do |config|
          config.consumer_key        = @consumer_key
          config.consumer_secret     = @consumer_secret
          config.access_token        = @access_token
          config.access_token_secret = @access_token_secret
        end

        @app.call(env)
      end
    end
  end
end
