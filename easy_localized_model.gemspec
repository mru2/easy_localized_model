$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "easy_localized_model/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "easy_localized_model"
  s.version     = EasyLocalizedModel::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of EasyLocalizedModel."
  s.description = "TODO: Description of EasyLocalizedModel."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "json"
  s.add_dependency "paramix"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "ruby-debug19"
end
