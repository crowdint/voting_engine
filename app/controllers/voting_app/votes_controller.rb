module VotingApp
  class VotesController < ApplicationController
    def create
      @submission = Submission.find(params[:submission_id])
      @submission.liked_by current_user
      render nothing: true
    end
  end
end
