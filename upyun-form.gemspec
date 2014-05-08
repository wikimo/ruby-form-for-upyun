# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'upyun/form/version'

Gem::Specification.new do |spec|
  spec.name          = "upyun-form"
  spec.version       = Upyun::Form::VERSION
  spec.authors       = ["wikimo"]
  spec.email         = ["gwikimo@gmail.com"]
  spec.summary       = %q{ruby-form-for-upyun}
  spec.description   = %q{upload picture to uppyun with form}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_dependency "faraday"
  spec.add_dependency 'mime-types'
end
