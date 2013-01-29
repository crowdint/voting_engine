module VotingApp
  class ApplicationController < ActionController::Base
    def method_missing(method_name)
      if method_name == :current_user
        Rails.logger.warn("current_user in VotingApp::ApplicationController should be overriden")
        User.create
      elsif method_name == :authenticate_user!
        Rails.logger.warn("authenticate_user! in VotingApp::ApplicationController should be overriden")
      end
    end

    helper_method :current_user
  end
end
