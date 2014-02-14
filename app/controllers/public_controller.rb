class PublicController < ApplicationController
  before_action :load_user

  def posts
    @posts = @user ? @user.posts : Post.all
    @posts = @posts.tagged_with(params[:tag]) if params[:tag].present?
    @posts = @posts.published_only
    @posts = @posts.visible_on_main unless @user
    @posts = @posts.includes(:user).includes(:section)
    @posts = @posts.in_order
    @posts = @posts.page(params[:page]).per(params[:per])
  end

  def post
    @posts = @user ? @user.posts : Post.all
    @posts = @posts.includes(:user).includes(:section)
    @posts = @posts.published_only
    @post = @posts.find(params[:id])
    @comments = @post.comments
    @comments = @comments.includes(:user)
    @comments = @comments.in_order
    @comments = @comments.page(params[:page]).per(params[:per])
  end

  def profile
    @posts = @user.last_posts
    @posts = @posts.in_order
    @posts = @posts.page(params[:page]).per(params[:per])
    @stickers = @user.stickers
  end

  def section
    @posts = @user ? @user.posts : Post.all
    @posts = @posts.published_only
    @posts = @posts.joins(:section).where(section_id: params[:id].to_i)
    @posts = @posts.includes(:user).includes(:section)
    @posts = @posts.in_order
    @posts = @posts.page(params[:page]).per(params[:per])
  end

  private

  def load_user
    if params[:user_name].present?
      @user = User.where(user_name: params[:user_name]).first || not_found  
    end
  end
end