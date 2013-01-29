require 'acts_as_votable'

module VotingApp
  class Submission < ActiveRecord::Base
    attr_accessible :accepted_at, :description

    acts_as_votable
  end
end
