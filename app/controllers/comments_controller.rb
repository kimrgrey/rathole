class CommentsController < ApplicationController
  include CacheManagment
  
  before_action :authenticate_user!
  before_action :load_user

  def create  
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = @user
    if @comment.save
      invalidate_post_caches(@post)
      PostMailer.new_comment_created(@comment).deliver
      flash[:notice] = I18n.t('comments.create.success')
    else
      flash[:error] = I18n.t('comments.create.failed')
    end
    redirect_to :back
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