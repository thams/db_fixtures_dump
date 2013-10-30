# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'db_fixtures_dump/version'

Gem::Specification.new do |spec|
  spec.name          = "db_fixtures_dump"
  spec.version       = DbFixturesDump::VERSION
  spec.authors       = ["Kurt Thams"]
  spec.email         = ["thams@thams.com"]
  spec.description   = %q{Rake task to dump all tables into yaml fixtures}
  spec.summary       = %q{Rake task to dump all tables into yaml fixtures}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
