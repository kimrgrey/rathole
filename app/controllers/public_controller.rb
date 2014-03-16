class PublicController < ApplicationController
  def profile
    @user = User.find_by(user_name: params[:user_name]) || not_found  
    @posts = @user.last_posts
    @posts = @posts.in_order
    @posts = @posts.page(params[:page]).per(params[:per])
    @stickers = @user.stickers
  end
end