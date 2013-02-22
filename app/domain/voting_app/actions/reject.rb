module VotingApp
  module Actions
    class Reject
      def initialize(user, request, options = {})
        @user       = user
        @request    = request
        @options    = options
      end

      def perform
        @request.reject!
        @request.notify_rejected @options
      end
    end
  end
end
