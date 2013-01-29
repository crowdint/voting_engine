module VotingApp
  class SubmissionsController < ApplicationController
    respond_to :json

    def index
      @submissions = Submission.all
      respond_with @submissions, methods: [:votes]
    end

    def show
      @submission = Submission.find(params[:id])
      respond_with @submission, methods: [:votes]
    end

    def create
      @submission = Submission.create params[:submission]
      respond_with @submission, methods: [:votes]
    end

    def update
      @submission = Submission.find(params[:id])
      @submission.update_attributes(params[:submission])
      respond_with @submission
    end

    def destroy
      @submission = Submission.destroy(params[:id])
      respond_with @submission
    end
  end
end
