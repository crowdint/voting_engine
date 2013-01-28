Rails.application.routes.draw do
  mount VotingApp::Engine => "/voting_app"
end
