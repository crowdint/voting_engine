module VotingApp
  class AcceptedController < ApplicationController

    def index
      @accepted = Submission.where('accepted_at is not ?', nil)
    end
  end
end
