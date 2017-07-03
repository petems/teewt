require 'thor'

module Teewt
  autoload :Middleware, 'teewt/middleware'

  class CLI < Thor
    include Thor::Actions
    ENV['THOR_COLUMNS'] = '120'

    !check_unknown_options

    class_option :quiet, type: :boolean, aliases: '-q'

    map '--version'      => :version,
        '-v'             => :version,
        'password-reset' => :password_reset

    desc 'help [COMMAND]', 'Describe commands or a specific command'
    def help(meth = nil)
      super
      say 'To learn more or to contribute, please see github.com/petems/teewt' unless meth
    end

    desc 'authorize', 'Authorize a Twitter account with teewt'
    long_desc "This takes you through a workflow for adding configuration
    details to teewt. First, you are asked for your API and Client keys,
    which are stored in ~/.teewt.

    You can retrieve your credentials from https://cloud.digitalocean.com/api_access

    Optionally, you can configure the default SSH key path and username
    used for `teewt ssh`. These default to '~/.ssh/id_rsa' and the
    $USER environment variable.
    "
    def authorize
      Middleware.sequence_authorize.call('teewt_action' => __method__,
                                         'user_quiet' => options[:quiet])
    end

    desc 'delete_tweet TWEET_ID', 'Delete a tweet'
    method_option 'id',
                  type: :string,
                  aliases: '-i',
                  desc: 'The ID of the tweet.'
    method_option 'confirm',
                  type: :boolean,
                  aliases: ['-c', '-y'],
                  desc: 'Skip confirmation of the action'
    def delete_tweet(name = nil)
      Middleware.sequence_delete_tweet.call('teewt_action' => __method__,
                                             'user_twitter_id' => options[:id],
                                             'user_confirm_action' => options[:confirm],
                                             'user_quiet' => options[:quiet])
    end

    desc 'config', 'Show your current config information'
    long_desc "This shows the current information in the .teewt config
    being used by the app
    "
    method_option 'hide',
                  type: :boolean,
                  default: false,
                  aliases: '-h',
                  desc: 'Hide your API keys'
    def config
      Middleware.sequence_config.call('teewt_action' => __method__,
                                      'user_hide_keys' => options[:hide])
    end

    desc 'verify', 'Check your Twitter credentials'
    long_desc "This tests that your credentials created by the \`authorize\`
    command that are stored in ~/.teewt are correct and allow you to connect
    to the API without errors.
    "
    def verify
      Middleware.sequence_verify.call('teewt_action' => __method__,
                                      'user_quiet' => options[:quiet])
    end

    desc 'version', 'Show version'
    def version
      say "Teewt #{Teewt::VERSION}"
    end

  end
end
