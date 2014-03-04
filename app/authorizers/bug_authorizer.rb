class BugAuthorizer < BaseAuthorizer
  def updatable_by?(user)
    resource.post.user_id == user.id
  end
end