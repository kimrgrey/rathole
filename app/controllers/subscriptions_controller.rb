class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user
  before_action :load_author
  before_action :load_post

  def subscribe
    if params[:post_id].present?
      subscribe_on_post
    elsif params[:author_id].present?
      subscribe_on_author
    else
      flash[:error] = I18n.t('users.subscribe.bad_request')
      redirect_to :back
    end
  end

  def unsubscribe
    if params[:post_id].present?
      unsubscribe_from_post
    elsif params[:author_id].present?
      unsubscribe_from_author
    else
      flash[:error] = I18n.t('users.unsubscribe.bad_request')
      redirect_to :back
    end
  end

  private

  def subscribe_on_post
    # TODO Add authorize!(:show, @post) here when cancancan start support of enums
    if @user.subscribe_on_post(@post)
      flash[:notice] = I18n.t('users.subscribe.success.post', :title => @post.title)
    else
      flash[:error] = I18n.t('users.subscribe.success.post')
    end
    redirect_to :back
  end

  def unsubscribe_from_post
    # TODO Add authorize!(:show, @post) here when cancancan start support of enums
    if @user.unsubscribe_from_post(@post)
      flash[:notice] = I18n.t('users.unsubscribe.success.post', :title => @post.title)
    else
      flash[:error] = I18n.t('users.unsubscribe.failed.post')
    end
    redirect_to :back
  end

  def subscribe_on_author
    authorize! :subscribe, @author
    if @user.subscribe_on_author(@author)
      flash[:notice] = I18n.t('users.subscribe.success.author', :name => @author.user_name)
    else
      flash[:error] = I18n.t('users.subscribe.failed.author')
    end
    redirect_to :back
  end

  def unsubscribe_from_author
    authorize! :unsubscribe, @author
    if @user.unsubscribe_from_author(@author)
      flash[:notice] = I18n.t('users.unsubscribe.success.author', :name => @author.user_name)
    else
      flash[:error] = I18n.t('users.unsubscribe.failed.author')
    end
    redirect_to :back
  end

  def load_user
    @user = current_user
  end

  def load_author
    @author = User.accessible_by(current_ability).find(params[:author_id]) if params[:author_id].present?
  end

  def load_post
    @post = Post.accessible_by(current_ability).find(params[:post_id]) if params[:post_id].present?
  end
end
