class CommentsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :load_parent

  def index
    @comments = @parent.comments.in_order.page(params[:page]).per(params[:per])
    respond_to do |format|
      format.js
    end
  end

  def create
    authorize! :create, Comment
    @comment = @parent.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  def update
    @comment = @parent.comments.accessible_by(current_ability).find(params[:id])
    authorize! :update, @comment
    @comment.attributes = comment_params
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment = @parent.comments.accessible_by(current_ability).find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def load_parent
    unless ["Post", "Bug"].include?(params[:parent_type])
      respond_to do |format|
        format.any { head :bad_request }
      end
      return
    end
    @parent = params[:parent_type].constantize.accessible_by(current_ability).find(params[:parent_id])
  end

  def comment_params
    params.permit(:body)
  end
end
