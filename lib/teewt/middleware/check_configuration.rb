module Teewt
  module Middleware
    # Check if the client has set-up configuration yet.
    class CheckConfiguration < Base
      def call(env)
        config = env['config']

        if !config || !config.data ||
          !config.consumer_key || !config.consumer_secret ||
          !config.access_token || !config.access_token_secret
          say 'You must run `teewt authorize` in order to connect to Twitter', :red
          exit 1
        end

        # If the user passes the global `-q/--quiet` flag, redirect
        # stdout
        $stdout = File.new('/dev/null', 'w') if env['user_quiet']

        @app.call(env)
      end
    end
  end
end
