class CommentAuthorizer < BaseAuthorizer
  def self.readable_by?(user)
    true
  end
end