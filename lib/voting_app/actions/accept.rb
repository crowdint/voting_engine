module VotingApp
  module Actions
    class Accept
      def initialize(user, submission)
        @user = user
        @submission = submission
      end

      def perform
        @submission.accept
      end
    end
  end
end
