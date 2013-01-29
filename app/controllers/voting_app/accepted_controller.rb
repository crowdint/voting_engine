module VotingApp
  class AcceptedController < ApplicationController

    def index
      @accepted = Submission.accepted
    end
  end
end
