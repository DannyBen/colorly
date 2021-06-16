require 'simplecov'
SimpleCov.start { enable_coverage :branch }

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

include Colorly
