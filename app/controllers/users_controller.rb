class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:avatar]

  before_action :authenticate_user!, except: [:show]

  def show
    if params[:user_name].present?
      @user = User.find_by(user_name: params[:user_name])
    else
      @user = current_user
    end
    do_show
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

  def do_show
    @posts = @user.last_posts
    @posts = @posts.in_order
    @posts = @posts.page(params[:page]).per(params[:per])
    @sections = @user.sections
    @stickers = @user.stickers
    @subscriptions = @user.subscriptions
    @subscriptions = @subscriptions.in_order
    render :show
  end

  def user_params
    params.require(:user).permit(:email, :user_name, :about, :password, :password_confirmation)
  end
end