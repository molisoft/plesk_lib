$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "plesk_kit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name          = "plesk_kit"
  s.version       = PleskKit::VERSION
  s.authors       = ["Dionne Saunders"]
  s.email         = ["linx@castlemako.com"]
  s.description   = "Provision Plesk 11"
  s.summary       = "Provision Plesk 11 Like a Pro!"
  s.homepage      = "https://github.com/lenoretres/plesk_kit"
  s.license       = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
