module Teewt
  module Middleware
    # Check if the client has set-up configuration yet.
    class FindTweet < Base
      def call(env)
        twitter_client = env['twitter']
        tweet_id = env['user_twitter_id']

        # First, if nothing is provided to us, we should quit and
        # let the user know.
        if !tweet_id
          say 'Teewt attempted to find a tweet with no arguments.', :red
          say "Try running `teewt #{env['teewt_action']} tweetid`", :green
          say "For more help run: `teewt help #{env['teewt_action']}`", :blue
          exit 1
        end

        # Easy for us if they provide an id. Just set it to the tweet_id
        if tweet_id
          say 'Tweet id provided. Finding Tweet...', nil, false

          check_status_exists(twitter_client, tweet_id)
        end

        @app.call(env)
      end
    end
  end
end
