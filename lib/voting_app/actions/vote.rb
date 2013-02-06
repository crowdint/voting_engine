module VotingApp
  module Actions
    class Vote
      def initialize(user, submission)
        @user       = user
        @submission = submission
      end

      def perform
        @submission.liked_by @user
      end
    end
  end
end
