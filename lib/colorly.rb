require 'yaml'
require 'requires'

requires 'colorly/exceptions'
requires 'colorly/version'
requires 'colorly'

module Colorly
  class << self
    def color_names
      @color_names ||= YAML.load_file(File.expand_path 'colorly/data/color-names.yml', __dir__)['colors']
    end
  end
end
