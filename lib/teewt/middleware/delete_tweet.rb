module Teewt
  module Middleware
    class DestroyImage < Base
      def call(env)
        twitter_client = env['twitter']
        tweet_id = env['user_twitter_id']

        say "Queuing delete tweet: #{tweet_id}...", nil, false

        delete_status_from_twitter(twitter_client, tweet_id)

        @app.call(env)
      end
    end
  end
end
