module VotingApp
  class AcceptedController < ApplicationController

    def index
      @accepted = Submission.accepted.page params[:page] || 1
      render status: :not_found, nothing: true if @accepted.empty?
    end
  end
end
