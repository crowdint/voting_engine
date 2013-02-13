VotingApp::Engine.routes.draw do
  root to: 'home#show'

  resources :requests, format: :json do
    match ':request_action', to: 'actions#create', format: :json,
      constraints: { request_action: /(vote|accept|reject|complete)/ },
      via: :post,
      as: 'actions'
  end

  match 'requests/:state', to: 'requests#index', format: :json,
    constraints: { state: /(accepted|done|promoted|rejected|processed)/ },
    as: 'submissions_by_state',
    via: :get

end
