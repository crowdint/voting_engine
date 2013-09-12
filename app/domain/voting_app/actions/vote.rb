module VotingApp
  module Actions
    class Vote
      def initialize(user, request, options = {})
        @user       = user
        @request    = RequestPresenter.new(request)
        @options    = options
      end

      def perform
        @request.liked_by @user
        @request.touch
        @request.notify_liked @options
      end
    end
  end
end
