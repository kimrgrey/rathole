class PublicController < ApplicationController
  def welcome
    @posts = Post.all
    @posts = @posts.tagged_with(params[:tag]) if params[:tag].present?
    @posts = @posts.order('posts.created_at DESC')
    @posts = @posts.page(params[:page]).per(params[:per])
  end
end