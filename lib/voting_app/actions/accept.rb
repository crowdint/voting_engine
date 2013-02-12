module VotingApp
  module Actions
    class Accept
      def initialize(user, submission, options = {})
        @user       = user
        @submission = submission
        @options    = options
      end

      def perform
        if @submission.accept
          @submission.notify_accepted @options
        end
      end
    end
  end
end
