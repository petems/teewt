require 'singleton'

module Teewt
  # This is the configuration object. It reads in configuration
  # from a .teewt file located in the user's home directory

  class Configuration
    include Singleton
    attr_reader :data
    attr_reader :path

    FILE_NAME = '.teewt'.freeze

    # Load config file from current directory, if not exit load from user's home directory
    def initialize
      @path = File.join(File.expand_path('.'), FILE_NAME)
      unless File.exist?(@path)
        @path = (ENV['TUGBOAT_CONFIG_PATH'] || File.join(File.expand_path('~'), FILE_NAME))
      end
      @data = load_config_file
    end

    # If we can't load the config file, self.data is nil, which we can
    # check for in CheckConfiguration
    def load_config_file
      require 'yaml'
      YAML.load_file(@path)
    rescue Errno::ENOENT
      return
    end

    def consumer_key
      @data['authentication']['consumer_key']
    end

    def consumer_secret
      @data['authentication']['consumer_secret']
    end

    def access_token
      @data['authentication']['access_token']
    end

    def access_token_secret
      @data['authentication']['access_token_secret']
    end

    # Re-runs initialize
    def reset!
      send(:initialize)
    end

    # Re-loads the config
    def reload!
      @data = load_config_file
    end

    # Writes a config file
    def create_config_file(consumer_key, consumer_secret, access_token, access_token_secret)
      # Default SSH Key path
      require 'yaml'
      File.open(@path, File::RDWR | File::TRUNC | File::CREAT, 0o600) do |file|
        data = {
          'authentication' => {
            'consumer_key' => consumer_key,
            'consumer_secret' => consumer_secret,
            'access_token' => access_token,
            'access_token_secret' => access_token_secret,
          },
        }
        file.write data.to_yaml
      end
    end
  end
end
