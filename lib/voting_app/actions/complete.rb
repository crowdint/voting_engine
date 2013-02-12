module VotingApp
  module Actions
    class Complete
      def initialize(user, submission, options = {})
        @user       = user
        @submission = submission
        @options    = options
      end

      def perform
        if @submission.complete
          @submission.notify_completed @options
        end
      end
    end
  end
end
