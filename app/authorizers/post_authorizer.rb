class PostAuthorizer < BaseAuthorizer
	def self.commentable_by?(user)
		user.present?
	end

  def self.publishable_by?(user)
    user.present?
  end

  def publishable_by?(user)
    check_owner user, resource
  end
end