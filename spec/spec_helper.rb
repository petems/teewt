require 'simplecov'
require 'simplecov-console'
require 'coveralls'
# Require every ruby file inside the spec/support directory, and subdirectories,
# so that it can be used directly in your tests.
Dir["./spec/support/**/*.rb"].each { |f| require f }

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Console,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter "/spec/shared"
  coverage_dir('coverage/')
end

require 'teewt'
require 'webmock/rspec'

require 'twitter'
require 'shared/environment'

RSpec.configure do |config|
  # Pretty tests
  config.color = true

  config.order = :random
end

def project_path
  File.expand_path('../..', __FILE__)
end

def fixture(fixture_name, format = 'json')
  File.new(project_path + "/spec/fixtures/#{fixture_name}.#{format}")
end

ENV['TUGBOAT_CONFIG_PATH'] = project_path + '/tmp/teewt'
