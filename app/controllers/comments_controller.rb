class CommentsController < ApplicationController
  include RoutesHelper
  
  before_action :authenticate_user!
  before_action :load_user

  authorize_actions_for Comment

  def create  
    @post = Post.published_only.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = @user
    @comment.save
  end

  def update
    @comment = @user.comments.find(params[:id])
    @comment.attributes = comment_params
    @comment.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize_action_for(@comment)
    @comment.destroy
  end

  private

  def load_user
    @user = current_user
  end

  def comment_params
    params.permit(:body)
  end
end