module VotingApp
  class Comment < ActiveRecord::Base
    attr_accessible :comment, :user

    belongs_to :user
    belongs_to :request

    validates :comment, presence: true

    delegate :name, to: :user, allow_nil: nil
  end
end
