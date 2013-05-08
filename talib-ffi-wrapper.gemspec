# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'talib/version'

Gem::Specification.new do |spec|
  spec.name          = "ffi-talib"
  spec.version       = Talib::VERSION
  spec.authors       = ["Marco Carvalho"]
  spec.email         = ["marco.carvalho.swasthya@gmail.com"]
  spec.description   = %q{talib wrapper}
  spec.summary       = %q{talib wrapper}
  spec.homepage      = ""
  spec.license       = "BSD"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.add_dependency('ffi', '>= 1.8.1')
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
