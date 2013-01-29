module VotingApp
  class AcceptedController < ApplicationController
    respond_to :json

    def index
      @accepted = Submission.where('accepted_at is not ?', nil)
      respond_with @accepted, methods: [:votes]
    end
  end
end
