require 'teewt/cli'
require 'teewt/config'
require 'teewt/version'
require 'json'
require 'hashie'
require 'hashie/logger'

Hashie.logger = Logger.new(nil)

# TODO: do this properly
# See: https://github.com/intridea/hashie/issues/394
require 'hashie'
require 'hashie/logger'
Hashie.logger = Logger.new(nil)

module Teewt
end
