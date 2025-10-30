lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'colorly/version'

Gem::Specification.new do |s|
  s.name        = 'colorly'
  s.version     = Colorly::VERSION
  s.summary     = 'Colorly color palette CLI'
  s.description = 'Command line for generating color palettes'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ['colorly']
  s.homepage    = 'https://github.com/dannyben/colorly'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 3.2'

  s.add_dependency 'chroma', '~> 0.2'
  s.add_dependency 'colsole', '~> 1.0'
  s.add_dependency 'filewatcher', '~> 2.0'
  s.add_dependency 'mister_bin', '~> 0.7'
  s.add_dependency 'ostruct', '~> 0.6'
  s.add_dependency 'requires', '~> 1.0'

  # FIXME: Remove when resolved.
  #        This is a sub-dependency of filewatcher which does not bundle logger.
  #        ref: https://github.com/filewatcher/filewatcher/pull/272
  s.add_dependency 'logger', '~> 1.6'

  s.metadata = {
    'bug_tracker_uri'       => 'https://github.com/DannyBen/colorly/issues',
    'changelog_uri'         => 'https://github.com/DannyBen/colorly/blob/master/CHANGELOG.md',
    'source_code_uri'       => 'https://github.com/dannyben/colorly',
    'rubygems_mfa_required' => 'true',
  }
end
