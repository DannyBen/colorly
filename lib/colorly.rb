require "yaml"
require "requires"
require "byebug" if ENV["BYEBUG"]
requires \
  "colorly/exceptions",
  "colorly/version",
  "colorly"

module Colorly
  class << self
    def color_names
      @color_names ||= YAML.load_file(File.expand_path "colorly/data/color-names.yml", __dir__)['colors']
    end
  end
end