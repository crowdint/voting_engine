require "voting_app/engine"
#require "voting_app/actions/vote"
#require "voting_app/actions/complete"
#require "voting_app/actions/accept"
#require "voting_app/actions/reject"

module VotingApp
  #autoload :Actions, 'voting_app/actions/'
  module Actions
    autoload :Vote, 'voting_app/actions/vote'
    autoload :Reject, 'voting_app/actions/reject'
    autoload :Accept, 'voting_app/actions/accept'
    autoload :Complete, 'voting_app/actions/complete'
  end
end
