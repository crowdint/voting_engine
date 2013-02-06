require 'acts_as_votable'

module VotingApp
  class User < ActiveRecord::Base
    attr_accessible :email, :name

    has_many :submissions

    acts_as_voter

    def become(klass)
      update_column :type, klass.to_s
    end
  end
end
