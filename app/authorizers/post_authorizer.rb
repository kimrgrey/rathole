class PostAuthorizer < BaseAuthorizer
  def self.readable_by?(user)
    true
  end

  def readable_by?(user)
    resource.published? || user.is_author_of?(resource)
  end
end