class CommentsController < ApplicationController
  include RoutesHelper
  
  before_action :authenticate_user!, :except => [:index]
  before_action :load_user

  def index
    if params[:class_name] == Post.name
      index_for_post
    elsif params[:class_name] == Bug.name
      index_for_bug
    else
      redirect_to :back
    end
  end

  def index_for_post
    @owner = Post.accessible_by(current_ability).find(params[:owner_id])
    @comments = @owner.comments
    @comments = @comments.in_order
    @comments = @comments.page(params[:page]).per(params[:per])
    render :index
  end

  def index_for_bug
    @owner = Bug.accessible_by(current_ability).find(params[:owner_id])
    @comments = @owner.comments
    @comments = @comments.in_order
    @comments = @comments.page(params[:page]).per(params[:per])
    render :index
  end

  def create  
    if params[:class_name] == Post.name
      create_for_post
    elsif params[:class_name] == Bug.name
      create_for_bug
    else
      redirect_to :back
    end
  end

  def create_for_post
    authorize! :create, Comments::PostComment
    @post = Post.accessible_by(current_ability).find(params[:owner_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = @user
    @comment.save
    render :create
  end

  def create_for_bug
    authorize! :create, Comments::BugComment
    @bug = Bug.accessible_by(current_ability).find(params[:owner_id])
    @comment = @bug.comments.build(comment_params)
    @comment.user = @user
    @comment.save
    render :create
  end

  def update
    @comment = Comments::Comment.find(params[:id])
    authorize! :update, @comment
    @comment.attributes = comment_params
    @comment.save
  end

  def destroy
    @comment = Comments::Comment.find(params[:id])
    authorize! :destroy, @comment
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