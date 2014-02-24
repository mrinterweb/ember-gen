# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ember-gen/version'

Gem::Specification.new do |spec|
  spec.name          = "ember-gen"
  spec.version       = Ember::Rails::Generator::VERSION
  spec.authors       = ["Sean McCleary"]
  spec.email         = ["seanmcc@gmail.com"]
  spec.description   = %q{generators for ember.js development}
  spec.summary       = %q{a better summary to come.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ember-rails"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
