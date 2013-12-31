class UserAuthorizer < ApplicationAuthorizer
  def self.readable_by?(user)
    user.present?
  end

  def self.updatable_by?(user)
    user.present?
  end

  def readable_by?(user)
    user.present?
  end

  def updatable_by?(user)
    user.id == resource.id
  end

  def deletable_by?(user)
    false
  end
end