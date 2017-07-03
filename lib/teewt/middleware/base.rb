module Teewt
  module Middleware
    # A base middleware class to initalize.
    class Base
      # Some colors for making things pretty.
      CLEAR      = "\e[0m".freeze
      RED        = "\e[31m".freeze
      GREEN      = "\e[32m".freeze
      YELLOW     = "\e[33m".freeze

      # We want access to all of the fun thor cli helper methods,
      # like say, yes?, ask, etc.
      include Thor::Shell

      def initialize(app)
        @app = app
        # This resets the color to "clear" on the user's terminal.
        say '', :clear, false
      end

      def call(env)
        @app.call(env)
      end

      def verify_credentials(twitter_client, say_success = false)
        begin
          twitter_client.verify_credentials
        rescue StandardError => e
          say 'Authentication with Twitter failed at an early stage', :red
          say "Error was: #{e}"
          exit 1
        end

        say 'Authentication with Twitter was successful.', :green if say_success
      end

      def check_status_exists(twitter_client, tweet_id)
        begin
          twitter_client.status(tweet_id)
        rescue StandardError => e
          say
          say "Error finding Tweet #{tweet_id}", :red
          say "Error was: #{e}", :red
          exit 1
        else
          say
          say "Found Tweet #{tweet_id}", :green
        end
      end

      def delete_status_from_twitter(twitter_client, tweet_id)
        begin
          twitter_client.destroy_status(tweet_id)
        rescue StandardError => e
          say
          say "Error deleting Tweet #{tweet_id}", :red
          say "Error was: #{e}", :red
          exit 1
        else
          say
          say "Deleted #{tweet_id}", :green
        end
      end

    end
  end
end
