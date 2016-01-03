module SignInHelpers
  def sign_in_as(user_name)
    user = User.find_by(:user_name => user_name)
    login_as(user, :scope => :user)
  end
end
