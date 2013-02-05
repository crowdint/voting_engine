VotingApp::Engine.routes.draw do
  root to: 'home#show'

  resources :submissions, format: :json do
    resources :votes, only: [:create]
  end

  match 'promoted', to: 'promoted#index', format: :json

end
