require 'acts_as_votable'

module VotingApp
  class Submission < ActiveRecord::Base
    attr_accessible :accepted_at, :description

    validates :description, presence: true

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
  end
end
