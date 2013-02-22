module VotingApp
  module Actions
    class Complete
      def initialize(user, request, options = {})
        @user       = user
        @request    = request
        @options    = options
      end

      def perform
        @request.complete!
        @request.notify_completed @options
      end
    end
  end
end
