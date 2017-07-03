require 'middleware'

module Teewt
  module Middleware
    autoload :AddKey, 'teewt/middleware/add_key'
    autoload :AskForCredentials, 'teewt/middleware/ask_for_credentials'
    autoload :Base, 'teewt/middleware/base'
    autoload :CheckConfiguration, 'teewt/middleware/check_configuration'
    autoload :CheckCredentials, 'teewt/middleware/check_credentials'
    autoload :CheckDropletActive, 'teewt/middleware/check_droplet_active'
    autoload :CheckDropletInactive, 'teewt/middleware/check_droplet_inactive'
    autoload :Config, 'teewt/middleware/config'
    autoload :ConfirmAction, 'teewt/middleware/confirm_action'
    autoload :CreateDroplet, 'teewt/middleware/create_droplet'
    autoload :RebuildDroplet, 'teewt/middleware/rebuild_droplet'
    autoload :DestroyDroplet, 'teewt/middleware/destroy_droplet'
    autoload :DestroyImage, 'teewt/middleware/delete_tweet'
    autoload :FindDroplet, 'teewt/middleware/find_droplet'
    autoload :FindTweet, 'teewt/middleware/find_tweet'
    autoload :HaltDroplet, 'teewt/middleware/halt_droplet'
    autoload :InfoDroplet, 'teewt/middleware/info_droplet'
    autoload :InfoImage, 'teewt/middleware/info_image'
    autoload :InjectClient, 'teewt/middleware/inject_client'
    autoload :InjectConfiguration, 'teewt/middleware/inject_configuration'
    autoload :ListDroplets, 'teewt/middleware/list_droplets'
    autoload :ListImages, 'teewt/middleware/list_images'
    autoload :ListRegions, 'teewt/middleware/list_regions'
    autoload :ListSizes, 'teewt/middleware/list_sizes'
    autoload :ListSSHKeys, 'teewt/middleware/list_ssh_keys'
    autoload :PasswordReset, 'teewt/middleware/password_reset'
    autoload :ResizeDroplet, 'teewt/middleware/resize_droplet'
    autoload :RestartDroplet, 'teewt/middleware/restart_droplet'
    autoload :SnapshotDroplet, 'teewt/middleware/snapshot_droplet'
    autoload :SSHDroplet, 'teewt/middleware/ssh_droplet'
    autoload :StartDroplet, 'teewt/middleware/start_droplet'
    autoload :WaitForState, 'teewt/middleware/wait_for_state'

    # Start the authorization flow.
    # This writes a ~/.teewt file, which can be edited manually.
    def self.sequence_authorize
      ::Middleware::Builder.new do
        use InjectConfiguration
        use AskForCredentials
        use InjectConfiguration
        use CheckConfiguration
        use InjectClient
        use CheckCredentials
      end
    end

    # This checks that the credentials in ~/.teewt are valid
    def self.sequence_verify
      ::Middleware::Builder.new do
        use InjectConfiguration
        use CheckConfiguration
        use InjectClient
        use CheckCredentials
      end
    end

    # Deletes a tweet
    def self.sequence_delete_tweet
      ::Middleware::Builder.new do
        use InjectConfiguration
        use CheckConfiguration
        use InjectClient
        use FindTweet
        use ConfirmAction
        use DestroyImage
      end
    end

    # Returns current used config
    def self.sequence_config
      ::Middleware::Builder.new do
        use Config
      end
    end

  end
end
