# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tele_config/version'

Gem::Specification.new do |spec|
  spec.name          = "tele_config"
  spec.version       = TeleConfig::VERSION
  spec.authors       = ["Markus Kahl"]
  spec.email         = ["machisuji@googlemail.com"]
  spec.summary       = %q{Downloads configuration files to where they need to be.}
  spec.homepage      = "https://github.com/machisuji/tele_config"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_dependency "aws-sdk-s3", "~> 1.9"
end
