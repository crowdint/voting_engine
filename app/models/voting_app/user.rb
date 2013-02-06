require 'acts_as_votable'

module VotingApp
  class User < ActiveRecord::Base
    attr_accessible :email, :name

    has_many :submissions

    acts_as_voter

  end
end
