$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "theme_importer_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "theme_importer_rails"
  s.version     = ThemeImporterRails::VERSION
  s.authors     = ["Josh Marchello"]
  s.email       = ["jraymarchello@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ThemeImporterRails."
  s.description = "TODO: Description of ThemeImporterRails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1"
end
