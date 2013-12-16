class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def show
    @user = profile_user
    @posts = @user.last_posts
    @sections = @user.sections
  end
end