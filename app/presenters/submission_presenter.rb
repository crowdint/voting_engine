class SubmissionPresenter < SimpleDelegator
  def can_vote?(user)
    self.user.id != user.id
  end

  def liked_by user
    if can_vote?(user)
      super
    else
      false
    end
  end
end
