module VotingApp
  class ActionsController < ApplicationController
    before_filter :authorize_action!

    def create
      @request = Request.find(params[:request_id])
      action = "VotingApp::Actions::#{params[:request_action].camelize}".constantize.new(current_user, @request, params)
      action.perform
    end

    private

    def authorize_action!
      if params[:request_action] != 'vote' && !current_user.admin?
        render status: :unauthorized, nothing: true
      end
    end
  end
end
