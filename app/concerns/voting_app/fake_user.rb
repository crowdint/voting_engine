module VotingApp
  module FakeUser
    extend ActiveSupport::Concern

    included do
      helper_method :current_user
    end

    def method_missing(method_name)
      if method_name == :current_user
        Rails.logger.warn("current_user in VotingApp::ApplicationController should be overriden")
        User.create
      elsif method_name == :authenticate_user!
        Rails.logger.warn("authenticate_user! in VotingApp::ApplicationController should be overriden")
      end
    end
  end
end
