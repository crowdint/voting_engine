module VotingApp
  module Actions
    class Promote
      def initialize(user, request, options = {})
        @user       = user
        @request    = request
        @options    = options
      end

      def perform
        @request.promote!
        @request.notify_promoted @options
      end
    end
  end
end