module VotingApp
  class Engine < ::Rails::Engine
    isolate_namespace VotingApp

    initializer 'votes limit' do |app|
      app.config.votes_limit = ENV['VOTES_LIMIT'] || 10
    end

  end
end
