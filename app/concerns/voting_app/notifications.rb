module VotingApp
  module Notifications
    extend ActiveSupport::Concern

    class Notification
      attr_accessor :submission, :options

      def initialize(submission, options)
        @submission = submission
        @options    = options
      end
    end

    def notify_accepted(options = {})
      notification = Notification.new self, options
      self.class.notify_observers :notify_accepted, notification
    end

    def notify_completed(options = {})
      notification = Notification.new self, options
      self.class.notify_observers :notify_completed, notification
    end

    def notify_created(options = {})
      notification = Notification.new self, options
      self.class.notify_observers :notify_created, notification
    end

    def notify_promoted(options = {})
      notification = Notification.new self, options
      self.class.notify_observers :notify_promoted, notification
    end

    def notify_rejected(options = {})
      notification = Notification.new self, options
      self.class.notify_observers :notify_rejected, notification
    end

    def notify_liked(options = {})
      notification = Notification.new self, options
      self.class.notify_observers :notify_liked, notification
    end

    def notify_commented(options = {})
      notification = Notification.new self, options
      self.class.notify_observers :notify_commen, notification
    end
  end
end
