module VotingApp
  module Actions
    class Complete
      def initialize(user, submission)
        @user       = user
        @submission = submission
      end

      def perform
        @submission.complete
      end
    end
  end
end
