class CommentsController < ApplicationController
  include CacheManagment
  include RoutesHelper
  
  before_action :authenticate_user!
  before_action :load_user

  def create  
    post = Post.find(params[:post_id])
    comment = post.comments.build(comment_params)
    comment.user = @user
    respond_to do |format|
      format.json do
        if comment.save
          invalidate_post_caches(post)
          PostMailer.new_comment_created(comment).deliver
          result = {
            date: I18n.l(comment.created_at),
            author: {
              avatar: comment.user_avatar_url(:thumb),
              name: @user.user_name,
              url:  public_profile_path(@user)
            },
            message: I18n.t('comments.create.success'),
            id: comment.id,
            body: comment.body_html,
            url: public_comment_url(comment)
          }
          render json: result, status: 200
        else
          result = {
            message: I18n.t('comments.create.failed'),
            errors: comment.errors.full_messages
          }
          render json: result, status: 422
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