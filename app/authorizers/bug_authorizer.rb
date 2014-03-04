class BugAuthorizer < BaseAuthorizer
  def readable_by?(user)
    resource.reporter_id == user.id || resource.post.user_id == user.id
  end
  
  def updatable_by?(user)
    resource.post.user_id == user.id
  end
end