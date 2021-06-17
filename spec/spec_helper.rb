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

RSpec.configure do |c|
  c.include SpecMixin
end
