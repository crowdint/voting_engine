VotingApp::Engine.routes.draw do
  root to: 'home#show'

  resources :requests, format: :json do
    match ':request_action', to: 'actions#create', format: :json,
      constraints: { request_action: /(vote|promote|accept|reject|complete|comment)/ },
      via: :post,
      as: 'actions'
  end

  match 'requests/:state/:time/:category', to: 'requests#index', format: :json,
    constraints: { state: /(accepted|done|promoted|rejected|processed)/,
                  time: /(month|year|all)/,
                  category: /office|hardware|software|equipment|food/ },
    as: 'submissions_by_state',
    via: :get

end
