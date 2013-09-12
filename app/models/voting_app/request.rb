require 'acts_as_votable'
require 'state_machine'

module VotingApp
  class Request < ActiveRecord::Base
    include Notifications

    attr_accessible :accepted_at, :description, :user_id, :category

    belongs_to :user

    has_many :comments

    validates :description, presence: true

    after_update :promote_request

    delegate :name, to: :user, allow_nil: nil
    delegate :email, to: :user, allow_nil: nil

    scope :in_last_month, :conditions => [ "created_at > ?", 1.month.ago ]
    scope :in_last_year, :conditions => [ "created_at > ?", 1.year.ago ]
    scope :office, :conditions => { :category => "office" }
    scope :software, :conditions => { :category => "software" }
    scope :hardware, :conditions => { :category => "hardware" }
    scope :equipment, :conditions => { :category => "equipment" }
    scope :food, :conditions => { :category => "food" }

    acts_as_votable

    state_machine initial: :submitted do
      state :accepted
      state :done
      state :promoted
      state :rejected
      state :submitted
      state :timed_out

      before_transition on: :accept do |request, transition|
        request.accepted_at ||= Time.now
      end

      before_transition on: :complete do |request, transition|
        request.done_at ||= Time.now
      end

      before_transition on: :promote do |request, transition|
        request.notify_promoted
        request.promoted_at ||= Time.now
      end

      before_transition on: :reject do |request, transition|
        request.rejected_at ||= Time.now
      end

      before_transition on: :time_out do |request, transition|
        request.rejected_at ||= Time.now
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

      event :time_out do
        transition submitted: :timed_out
      end

    end

    def commenters
      commenters = []
      comments.each { |c| commenters << c.user.email }
      commenters.uniq
    end

    def supporters
      votes.map { |v| v.voter.name }.uniq.sort
    end

    def supporters_emails
      supporters = []
      likes.each { |l| supporters << l.voter.email }
      supporters << email
      supporters.uniq
    end

    def involved_users
      involved = supporters_emails + commenters
      involved.uniq
    end

    class << self

      def accepted
        includes(:comments, :user, :votes).with_state(:accepted).order('accepted_at ASC')
      end

      def done
        includes(:comments, :user, :votes).with_state(:done).order('done_at ASC')
      end

      def promoted
        includes(:comments, :user, :votes).with_state(:promoted).order('promoted_at ASC')
      end

      def rejected
        includes(:comments, :user, :votes).with_state(:rejected).order('rejected_at ASC')
      end

      def submitted
        includes(:comments, :user, :votes).with_state(:submitted).order('created_at ASC')
      end

      def timed_out
        includes(:comments, :user, :votes).with_state(:timed_out).order('created_at ASC')
      end

      def processed
        includes(:comments, :user, :votes).without_state(:submitted).order('created_at ASC')
      end

      def cache_key
        [count, maximum(:updated_at).try(:utc).try(:to_s, :number)]
      end

    end

    def promote_request
      self.promote if self.enough_votes?
    end

    def enough_votes?
      votes.size >= Engine.config.votes_limit
    end
  end
end
