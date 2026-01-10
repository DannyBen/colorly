require 'simplecov'
unless ENV['NOCOV']
  SimpleCov.start do
    enable_coverage :branch if ENV['BRANCH_COV']
    coverage_dir 'spec/coverage'
  end
end

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
LEEWAY = ENV['CI'] ? 40 : 0

RSpec.configure do |c|
  c.include SpecMixin
  c.filter_run_excluding :slow if ENV['FAST']
end
