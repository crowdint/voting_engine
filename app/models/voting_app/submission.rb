module VotingApp
  class Submission < ActiveRecord::Base
    attr_accessible :accepted_at, :description

    def votes
      0
    end
  end
end
