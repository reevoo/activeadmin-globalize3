$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_admin/globalize3/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin-globalize3"
  s.version     = ActiveAdmin::Globalize3::VERSION
  s.authors     = ["Stefano Verna"]
  s.email       = ["stefano.verna@gmail.com"]
  s.homepage    = "http://github.com/cantierecreativo/activeadmin-globalize3"
  s.summary     = "Handles globalize3 translations"
  s.description = "Handles globalize3 translations"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "activeadmin"
  s.add_dependency "globalize"

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'combustion', '~> 0.3.1'
end
