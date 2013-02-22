module VotingApp
  module Actions
    class Accept
      def initialize(user, request, options = {})
        @user       = user
        @request    = request
        @options    = options
      end

      def perform
        @request.accept!
        @request.notify_accepted @options
      end
    end
  end
end
