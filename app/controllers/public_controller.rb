class PublicController < ApplicationController
  before_action :load_user

  def posts
    @posts = @user ? @user.posts : Post.all
    @posts = @posts.tagged_with(params[:tag]) if params[:tag].present?
    @posts = @posts.ordered_by_default
    @posts = @posts.page(params[:page]).per(params[:per])
  end

  def post
    @posts = @user ? @user.posts : Post.all
    @posts = @posts.joins(:user)
    @post = @posts.find(params[:id])
  end

  def profile
    @posts = @user.last_posts
    @posts = @posts.ordered_by_default
    @posts = @posts.page(params[:page]).per(params[:per])
  end

  def section
    @posts = @user ? @user.posts : Post.all
    @posts = @posts.joins(:section).where(section_id: params[:id].to_i)
    @posts = @posts.ordered_by_default
    @posts = @posts.page(params[:page]).per(params[:per])
  end

  private

  def load_user
    if params[:user_name].present?
      @user = User.where(user_name: params[:user_name]).first || not_found  
    end
  end
end