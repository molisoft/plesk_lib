# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'test/gem/version'

Gem::Specification.new do |spec|
  spec.name          = "plesk_lib"
  spec.version       = Test::Gem::VERSION
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

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
