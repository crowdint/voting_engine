module VotingApp
  class ActionsController < ApplicationController
    before_filter :authorize_action!

    def create
      @submission = Submission.find(params[:submission_id])
      action = "VotingApp::Actions::#{params[:submission_action].camelize}".constantize.new(current_user, @submission, params)
      action.perform
    end

    private

    def authorize_action!
      if params[:submission_action] != 'vote' && !current_user.admin?
        render status: :unauthorized, nothing: true
      end
    end
  end
end
