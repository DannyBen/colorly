require 'simplecov'
SimpleCov.start { enable_coverage :branch }

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

require_relative 'spec_mixin'

include Colorly

# Consistent Colsole output (for rspec_fixtures)
ENV['TTY'] = 'off'
ENV['COLUMNS'] = '80'
ENV['LINES'] = '30'

# The `raise_approval` matcher provides different results in different Ruby
# versions, so this constant is used as a diff modifier.
LEEWAY = ENV['CI'] ? 30 : 0

RSpec.configure do |c|
  c.include SpecMixin
  c.filter_run_excluding :slow if ENV['FAST']
end
