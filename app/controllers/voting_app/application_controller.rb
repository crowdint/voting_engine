module VotingApp
  class ApplicationController < ActionController::Base
    include ApiErrorHandling
    include FakeUser
  end
end
