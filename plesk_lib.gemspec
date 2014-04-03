# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plesk_lib/version'

Gem::Specification.new do |spec|
  spec.name          = "plesk_lib"
  spec.version       = PleskLib::VERSION
  spec.authors       = ["Phillipp Röll"]
  spec.email         = ["phillipp.roell@trafficplex.de"]
  spec.summary       = %q{Plesk 11 provisioning library. Extracted out of plesk_kit}
  spec.description   = %q{Add customers, resellers, service plans and subscriptions to plesk via the XML RPC API}
  spec.homepage      = "https://github.com/phillipp/plesk_lib"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 3.0.0"
  spec.add_runtime_dependency "ox", "~> 2.1"
  spec.add_runtime_dependency "builder", ">= 3.0"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "vcr", "~> 2.8.0"
  spec.add_development_dependency "webmock", "~> 1.17.4"
  spec.add_development_dependency "pry", "~> 0.9.12.6"
end
