module VotingApp
  class RequestAction
    def self.create(user, request, options)
      klass = "VotingApp::Actions::#{options[:request_action].camelize}"
      klass.constantize.new(user, request, options)
    end
  end
end
