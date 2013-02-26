class RequestPresenter < SimpleDelegator
  def can_vote?(u)
    self.user.id != u.id && u.voted_on?(__getobj__)
  end

  def liked_by user
    if can_vote?(user)
      super
    else
      false
    end
  end
end
