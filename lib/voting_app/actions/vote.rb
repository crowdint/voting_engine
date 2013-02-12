module VotingApp
  module Actions
    class Vote
      def initialize(user, submission, options = {})
        @user       = user
        @submission = SubmissionPresenter.new(submission)
        @options    = options
      end

      def perform
        if @submission.liked_by @user
          @submission.notify_liked @options
        end
      end
    end
  end
end
