module VotingApp
  class AcceptedController < ApplicationController

    def index
      @accepted = Submission.accepted.page params[:page] || 1
    end
  end
end
