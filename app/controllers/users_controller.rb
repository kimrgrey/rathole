class UsersController < ApplicationController
  include CacheManagment

  skip_before_action :verify_authenticity_token, only: [:avatar]

  before_action :authenticate_user!
  before_action :load_user

  def show
    @posts = @user.last_posts
    @sections = @user.sections
    @stickers = @user.stickers
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
    input = request.body.read
    tmp = Tempfile.new('avatar')
    begin  
      tmp.binmode
      tmp.write(input)
      tmp.rewind
      @user.avatar = tmp
      if @user.save
        result = {
          message: I18n.t('users.avatar.success'),
          urls: {
            original: @user.avatar_url,
            thumb: @user.avatar_url(:thumb)
          }
        }
        render json: result, status: 200
      else
        result = {
          message: I18n.t('users.avatar.failed'),
          errors: @user.errors.full_messages
        }
        render json: result, status: 422
      end
    ensure
      tmp.close
      tmp.unlink
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :user_name, :about, :password, :password_confirmation)
  end

  def load_user
    @user = current_user
  end
end