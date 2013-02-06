class SubmissionPresenter < SimpleDelegator
  def can_vote?(user)
    self.user != user
  end

  def liked_by user
    if can_vote?(user)
      super
    else
      false
    end
  end
end
