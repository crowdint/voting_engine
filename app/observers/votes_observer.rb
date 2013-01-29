class VotesObserver < ActiveRecord::Observer
  observe ActsAsVotable::Vote

  def after_create(vote)
    vote.votable.accept if vote.votable.enough_votes?
  end

end
