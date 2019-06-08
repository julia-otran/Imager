# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imager/version'

Gem::Specification.new do |spec|
  spec.name          = "imager"
  spec.version       = Imager::VERSION
  spec.authors       = ["Guilherme Otranto"]
  spec.email         = ["guilherme_otran@hotmail.com"]
  spec.description   = %q{A remote storange and resizer client for images.}
  spec.summary       = %q{Imager Client API}
  spec.homepage      = "https://github.com/guilherme-otran/Imager"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "webmock", "~> 3.6"
  spec.add_development_dependency "vcr", "~> 5.0"
  spec.add_development_dependency "turn", "~> 0.9"
  spec.add_development_dependency "rack-test", "~> 1.1"
  spec.add_dependency "httparty", "~> 0.17"
  spec.add_dependency "json", "~> 2.2"
end
