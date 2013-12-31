class PostAuthorizer < BaseAuthorizer
	def self.commentable_by?(user)
		user.present?
	end
end