module VotingApp
  module Actions
    class Reject
      def initialize(user, submission, options = {})
        @user       = user
        @submission = submission
        @options    = options
      end

      def perform
        if @submission.reject
          @submission.notify_rejected @options
        end
      end
    end
  end
end
