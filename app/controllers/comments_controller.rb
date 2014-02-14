class CommentsController < ApplicationController
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
          @user.subscribe_on_post!(@post)
          send_notification_emails
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

  def send_notification_emails
    @post.subscriptions.each do |subscription|
      PostMailer.notify_subscriber_about_comment(subscription.subscriber, @comment).deliver
    end
  end

  def load_user
    @user = current_user
  end

  def comment_params
    params.permit(:body)
  end
end