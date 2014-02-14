class CommentsController < ApplicationController
  include CacheManagment
  include RoutesHelper
  
  before_action :authenticate_user!
  before_action :load_user

  def create  
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = @user
    respond_to do |format|
      format.json do
        if @comment.save
          PostMailer.new_comment_created(@comment).deliver
          render 'created'
        else
          render 'failed'
        end
      end
    end
  end

  def destroy
    redirect_to :back
  end

  private

  def load_user
    @user = current_user
  end

  def comment_params
    params.permit(:body)
  end
end