# frozen_string_literal: true

# rubocop:disable Metrics/LineLength

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kandr-rails-extensions/version'

Gem::Specification.new do |s|
  s.name        = 'kandr-rails-extensions'
  s.version     = KandrRailsExtensions::VERSION
  s.summary     = 'Rails extensions for K&R Software apps'
  s.description = 'A set of Rails extensions for use in K&R Software applications'
  s.authors     = ['Karl Wilbur']
  s.email       = ['karl@kandrsoftware.com']
  s.homepage    = 'https://github.com/K-and-R/kandr-rails-extensions'
  s.platform    = Gem::Platform::RUBY
  s.license     = 'BSD-3-Clause'

  s.files       = `git ls-files lib kandr-rails-extensions.gemspec LICENSE`.split($INPUT_RECORD_SEPARATOR)

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov_json_formatter', '0.1.0' 

  s.required_ruby_version = '>= 2.7.0'

  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'ostruct'
end

# rubocop:enable Metrics/LineLength
