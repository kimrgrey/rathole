class UsersController < ApplicationController
  include CacheManagment
  
  before_action :authenticate_user!
  before_action :load_user

  def show
    @posts = @user.last_posts
    @sections = @user.sections
  end

  def avatar
    if params[:file].present?
      @user.avatar = open(params[:file], 'rb')
      if @user.save
        invalidate_user_cache(@user)
        flash[:notice] = I18n.t('users.avatar.success')
      else
        flash[:error] = I18n.t('users.avatar.failed')
      end
    end
    redirect_to user_path
  end

  private

  def load_user
    @user = current_user
  end
end