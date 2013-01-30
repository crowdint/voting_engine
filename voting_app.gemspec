$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "voting_app/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "voting_app"
  s.version     = VotingApp::VERSION
  s.authors     = ['Crowd Interactive', 'Ivan Calderon', 'Herman Moreno']
  s.email       = %w(opensource@crowdint.com ivan.calderon@crowdint.com herman.moreno@crowdint.com)
  s.homepage    = 'http://github.com/crowdint/voting_app'
  s.summary     = "TODO: Summary of VotingApp."
  s.description = "TODO: Description of VotingApp."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]


  s.add_dependency "acts_as_votable", "~> 0.5.0"
  s.add_dependency "rails", "~> 3.2.11"
  s.add_dependency "haml-rails"
  s.add_dependency "state_machine"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "json_spec"
end
