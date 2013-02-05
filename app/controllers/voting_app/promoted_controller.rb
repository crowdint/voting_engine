module VotingApp
  class PromotedController < ApplicationController

    def index
      @promoted = Submission.promoted.page params[:page] || 1
      render status: :not_found, nothing: true if @promoted.empty?
    end
  end
end
