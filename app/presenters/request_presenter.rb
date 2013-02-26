class RequestPresenter < SimpleDelegator
  def can_vote?(u)
    self.user.id != u.id && !self.user.voted_on?(self)
  end

  def liked_by user
    if can_vote?(user)
      super
    else
      false
    end
  end
end
