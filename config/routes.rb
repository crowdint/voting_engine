VotingApp::Engine.routes.draw do
  root to: 'home#show'

  resources :submissions, format: :json do
    match ':submission_action', to: 'actions#create', format: :json,
      constraints: { submission_action: /(vote|accept|reject|complete)/ },
      via: :post,
      as: 'actions'
  end

  match 'submissions/:state', to: 'submissions#index', format: :json,
    constraints: { state: /(accepted|done|promoted|rejected|processed)/ },
    as: 'submissions_by_state',
    via: :get

end
