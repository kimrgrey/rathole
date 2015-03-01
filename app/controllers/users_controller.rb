class UsersController < ApplicationController
  before_action :store_current_url_in_session, :only => [:show]
  before_action :authenticate_user!, :except => [:show]

  def show
    if params[:user_name].present?
      @user = User.accessible_by(current_ability).find_by(:user_name => params[:user_name])
    else
      @user = current_user
    end
    @user.present? ? do_show : not_found 
  end

  def update
    current_user.attributes = user_params
    if current_user.save
      flash[:notice] = I18n.t('users.update.success')
      redirect_to user_path
    else
      flash[:error] = I18n.t('users.update.failed')
      @user = current_user
      do_show
    end
  end

  def avatar
    @user = current_user
    @picture = current_user.pictures.find(params[:picture_id])
    @user.avatar_path = @picture.image_url(:thumb)
    @user.save ? head(200) : head(422)
  end

  private

  def do_show
    @posts = @user.last_posts.accessible_by(current_ability)
    @posts = @posts.in_order
    @posts = @posts.page(params[:page]).per(params[:per])
    @sections = @user.sections.accessible_by(current_ability)
    @stickers = @user.stickers.accessible_by(current_ability)
    @subscriptions = @user.subscriptions.accessible_by(current_ability)
    @subscriptions = @subscriptions.in_order
    render :show
  end

  def user_params
    params.require(:user).permit(:email, :user_name, :about, :password, :password_confirmation)
  end
end