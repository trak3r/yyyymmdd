# frozen_string_literal: true

require_relative 'lib/yyyymmdd/version'

Gem::Specification.new do |spec|
  spec.name = 'yyyymmdd'
  spec.version = Yyyymmdd::VERSION
  spec.authors = ['Thomas Davis']
  spec.email = ['github@rudiment.net']

  spec.summary = 'Integer calendar-day (YYYYMMDD) and related compact date/time formats'
  spec.description = <<~DESC
    Convert between Date/Time and compact integer encodings used as calendar-day keys:
    YYYYMMDD, YYYYMMDDHHMMSS, HHMM, and YEARWEEK. Includes an ActiveModel validator
    and param-validation helpers.
  DESC
  spec.homepage = 'https://github.com/trak3r/yyyymmdd'
  spec.required_ruby_version = '>= 3.1.0'
  spec.license = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*', 'LICENSE', 'README.md', 'CHANGELOG.md', 'yyyymmdd.gemspec']
  spec.require_paths = ['lib']

  spec.add_dependency 'activemodel', '>= 6.1'
  spec.add_dependency 'activesupport', '>= 6.1'

  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
end
