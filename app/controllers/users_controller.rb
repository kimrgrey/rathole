class UsersController < ApplicationController
  include CacheManagment
  
  before_action :authenticate_user!
  before_action :load_user

  def show
    @posts = @user.last_posts
    @sections = @user.sections
  end

  def update
    @user.attributes = user_params
    if @user.save
      invalidate_user_cache(@user)
      flash[:notice] = I18n.t('users.update.success')
      redirect_to user_path
    else
      flash[:error] = I18n.t('users.update.failed')
      @posts = @user.last_posts
      @sections = @user.sections
      render :show
    end
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

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def load_user
    @user = current_user
  end
end