class ApplicationAuthorizer < Authority::Authorizer
  def self.default(adjective, user)
    Rails.logger.info "default authorizer"
    false
  end

  protected 
  
  def check_owner(user, resource)
    resource.user_id == user.id
  end
end
