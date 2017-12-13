module WikisHelper
  def can_see_wiki?(user, wiki)
    !wiki.private || wiki.user_id == user.id || user.admin? || user.premium?
  end
end
