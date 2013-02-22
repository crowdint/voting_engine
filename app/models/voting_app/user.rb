require 'acts_as_votable'

module VotingApp
  class User < ActiveRecord::Base
    attr_accessible :email, :name

    has_many :requests

    has_many :comments

    acts_as_voter

  end
end
