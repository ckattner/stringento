# frozen_string_literal: true

require './lib/stringento/version'

Gem::Specification.new do |s|
  s.name        = 'stringento'
  s.version     = Stringento::VERSION
  s.summary     = 'This library provides a pluggable string templating system.'

  s.description = <<-DESCRIPTION
    At its core, it can take a templated string (such as: '{last_name}, {first_name} {middle_name}') and a input object (default is a plain old Ruby object) and it will dynamically resolve the string based on the input.
  DESCRIPTION

  s.authors     = ['Matthew Ruggio']
  s.email       = ['mruggio@bluemarblepayroll.com']
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.bindir      = 'exe'
  s.executables = []
  s.homepage    = 'https://github.com/bluemarblepayroll/stringento'
  s.license     = 'MIT'
  s.metadata    = {
    'bug_tracker_uri' => 'https://github.com/bluemarblepayroll/stringento/issues',
    'changelog_uri' => 'https://github.com/bluemarblepayroll/stringento/blob/master/CHANGELOG.md',
    'documentation_uri' => 'https://www.rubydoc.info/gems/stringento',
    'homepage_uri' => s.homepage,
    'source_code_uri' => s.homepage
  }

  s.required_ruby_version = '>= 2.5'

  s.add_development_dependency('faker', '~>1')
  s.add_development_dependency('guard-rspec', '~>4.7')
  s.add_development_dependency('pry', '~>0')
  s.add_development_dependency('rake', '~>13.0')
  s.add_development_dependency('rspec', '~> 3.8')
  s.add_development_dependency('rubocop', '~>0.88.0')
  s.add_development_dependency('simplecov', '~>0.18.5')
  s.add_development_dependency('simplecov-console', '~>0.7.0')
end
