require 'acts_as_votable'
require 'state_machine'

module VotingApp
  class Submission < ActiveRecord::Base
    attr_accessible :accepted_at, :description, :user_id

    belongs_to :user

    validates :description, presence: true

    after_update :promote_submission

    acts_as_votable

    state_machine initial: :submitted do
      state :accepted
      state :done
      state :promoted
      state :rejected
      state :submitted

      before_transition on: :accept do |submission, transition|
        submission.accepted_at ||= Time.now
      end

      before_transition on: :complete do |submission, transition|
        submission.done_at ||= Time.now
      end

      before_transition on: :promote do |submission, transition|
        submission.promoted_at ||= Time.now
      end

      before_transition on: :reject do |submission, transition|
        submission.rejected_at ||= Time.now
      end

      event :accept do
        transition promoted: :accepted
      end

      event :complete do
        transition accepted: :done
      end

      event :promote do
        transition submitted: :promoted
      end

      event :reject do
        transition promoted: :rejected
      end

    end

    class << self

      def accepted
        with_state(:accepted).order('accepted_at DESC')
      end

      def done
        with_state(:done).order('done_at DESC')
      end

      def promoted
        with_state(:promoted).order('promoted_at DESC')
      end

      def rejected
        with_state(:rejected).order('rejected_at DESC')
      end

      def submitted
        with_state(:submitted).order('created_at DESC')
      end

    end

    def promote_submission
      self.promote if self.enough_votes?
    end

    def enough_votes?
      votes.size >= Engine.config.votes_limit
    end
  end
end
