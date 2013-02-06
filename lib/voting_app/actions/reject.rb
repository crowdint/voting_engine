module VotingApp
  module Actions
    class Reject
      def initialize(user, submission)
        @user       = user
        @submission = submission
      end

      def perform
        @submission.reject
      end
    end
  end
end
