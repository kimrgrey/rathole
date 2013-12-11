class PublicController < ApplicationController
  def welcome
    @posts = Post.all
    @posts = @posts.order('posts.created_at DESC')
    @posts = @posts.page(params[:page]).per(params[:per])
  end
end