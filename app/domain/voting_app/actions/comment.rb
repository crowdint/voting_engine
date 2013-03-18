module VotingApp
  module Actions
    class Comment
      def initialize(user, request, options = {})
        @user       = user
        @request    = request
        @options    = options
      end

      def perform
        @request.comments.create! comment: @options[:comment], user: @user
        @request.notify_commented @options
      end
    end
  end
end
