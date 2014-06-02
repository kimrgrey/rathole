class PublicController < ApplicationController
  def welcome
    @posts = user_signed_in? ? Post.my_or_published(current_user) : Post.published_only
    @posts = @posts.tagged_with(params[:tag]) if params[:tag].present?
    @posts = @posts.visible_on_main 
    @posts = @posts.in_order
    @posts = @posts.page(params[:page]).per(params[:per])
  end

  def overview
    @users = User.all
    @users = @users.in_featured_order
  end
end