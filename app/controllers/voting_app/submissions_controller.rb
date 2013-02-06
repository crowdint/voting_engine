module VotingApp
  class SubmissionsController < ApplicationController

    def index
      state = params[:state] || 'submitted'
      @submissions = Submission.send(state).page params[:page] || 1
      render status: :not_found, nothing: true if @submissions.empty?
    end

    def show
      @submission = Submission.find(params[:id])
    end

    def create
      params[:submission].merge!({ user_id: current_user.id })
      @submission = Submission.create params[:submission]
      if @submission
        render status: :created
      else
        render status: :unprocessable_entity
      end
    end

    def update
      @submission = Submission.find(params[:id])
      if @submission.update_attributes(params[:submission])
        render status: :no_content, nothing: true
      else
        render status: :unprocessable_entity, nothing: true
      end
    end

    def destroy
      @submission = Submission.destroy(params[:id])
      render status: :no_content, nothing: true
    end
  end
end
