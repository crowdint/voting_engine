require 'acts_as_votable'
require 'state_machine'

module VotingApp
  class Submission < ActiveRecord::Base
    attr_accessible :accepted_at, :description, :user_id

    belongs_to :user

    validates :description, presence: true

    after_update :accept_submission

    acts_as_votable

    state_machine initial: :submitted do
      state :submitted
      state :accepted

      before_transition on: :accept do |submission, transition|
        submission.accepted_at ||= Time.now
      end

      event :accept do
        transition submitted: :accepted
      end
    end

    class << self
      def accepted
        with_state(:accepted).order('accepted_at DESC')
      end

      def submitted
        with_state(:submitted).order('created_at DESC')
      end
    end

    def accept_submission
      self.accept if self.enough_votes?
    end

    def enough_votes?
      votes.size >= Engine.config.votes_limit
    end
  end
end
