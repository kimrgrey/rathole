class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user

  def show
    @posts = @user.last_posts
    @sections = @user.sections
  end

  private

  def load_user
    @user = current_user
  end
end