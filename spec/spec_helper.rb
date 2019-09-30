# frozen_string_literal: true

require 'rubygems'
require 'rspec'
require 'pry'
require 'active_support'
require 'active_support/all'

require 'simplecov'
SimpleCov.start 'rails' do
  # Ignore the version file
  add_filter 'lib/kandr-rails-extensions/version.rb'
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'kandr-rails-extensions'
