# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'teewt/version'

Gem::Specification.new do |gem|
  gem.name          = 'teewt'
  gem.version       = Teewt::VERSION
  gem.authors       = ['Peter Souter']
  gem.email         = ['p.morsou@gmail.com']
  gem.description   = 'A command line tool for deleting old tweets and favs.'
  gem.summary       = 'A command line tool for deleting old tweets and favs.'
  gem.homepage      = 'https://github.com/petems/teewt'

  gem.files                 = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables           = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files            = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths         = ['lib']
  gem.required_ruby_version = '>= 1.9.2'

  gem.add_dependency 'thor', '0.18.1'
  gem.add_dependency 'ibsciss-middleware', '0.4.2'
  # Update back to faraday_middleware when https://github.com/lostisland/faraday_middleware/pull/157 merged
  gem.add_dependency 'faraday_middleware_safeyaml', '0.12.pre.safeyaml'
  gem.add_dependency 'faraday', '0.9.2'
  gem.add_dependency 'hashie', '3.5.5'
  gem.add_dependency 'activesupport', '4.1.11'
  gem.add_dependency 'twitter'

  gem.add_development_dependency 'rake', '< 11.0'
  gem.add_development_dependency 'rspec-core', '~> 3.6'
  gem.add_development_dependency 'rspec-expectations', '~> 3.6'
  gem.add_development_dependency 'rspec-mocks', '~> 3.6'
  gem.add_development_dependency 'webmock', '~> 1.11.0'
  gem.add_development_dependency 'simplecov', '0.10'
  gem.add_development_dependency 'simplecov-console', '0.2.0'
  gem.add_development_dependency 'coveralls', '~> 0.6.7'
  gem.add_development_dependency 'aruba', '0.7.4'
  gem.add_development_dependency 'pry', '0.10.4'
  gem.add_development_dependency 'rb-readline', '0.5.3'
  gem.add_development_dependency 'vcr', '2.9.3'
  gem.add_development_dependency 'cucumber', '2.0.2'
  gem.add_development_dependency 'rubocop', '0.47.1'
  gem.add_development_dependency 'rubocop-rspec', '1.5.0'
  gem.add_development_dependency 'license_finder'
end
