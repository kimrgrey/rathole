class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:avatar]

  before_action :authenticate_user!
  before_action :load_user

  def show
    @posts = @user.last_posts
    @sections = @user.sections
    @stickers = @user.stickers
    @subscriptions = @user.subscriptions
    @subscriptions = @subscriptions.in_order
  end

  def update
    @user.attributes = user_params
    if @user.save
      flash[:notice] = I18n.t('users.update.success')
      redirect_to user_path
    else
      flash[:error] = I18n.t('users.update.failed')
      @posts = @user.last_posts
      @sections = @user.sections
      render :show
    end
  end

  def subscribe
    @author = User.find(params[:author_id])
    if @user.subscribe_on_author(@author)
      flash[:notice] = I18n.t('users.subscribe.success', name: @author.user_name)
    else
      flash[:error] = I18n.t('users.subscribe.failed')
    end
    redirect_to :back
  end

  def unsubscribe
    @author = User.find(params[:author_id])
    if @user.unsubscribe_on_author(@author)
      flash[:notice] = I18n.t('users.unsubscribe.success', name: @author.user_name)
    else
      flash[:error] = I18n.t('users.unsubscribe.failed')
    end
    redirect_to :back
  end

  def events
    @events = @user.events(Time.now - 1.week, Time.now)
    @events = @events.order('events.updated_at DESC')
    @events = @events.page(params[:page]).per(params[:per])
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