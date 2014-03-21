class CommentsController < ApplicationController
  include RoutesHelper
  
  before_action :authenticate_user!
  before_action :load_user

  authorize_actions_for Comments::PostComment

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
    @owner = Post.find(params[:owner_id])
    @comments = @owner.comments
    @comments = @comments.in_order
    @comments = @comments.page(params[:page]).per(params[:per])
    render :index
  end

  def index_for_bug
    @owner = Bug.find(params[:owner_id])
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
    @post = Post.find(params[:owner_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = @user
    @comment.save
    render :create
  end

  def create_for_bug
    @bug = Bug.find(params[:owner_id])
    @comment = @bug.comments.build(comment_params)
    @comment.user = @user
    @comment.save
    render :create
  end

  def update
    @comment = Comments::Comment.find(params[:id])
    authorize_action_for(@comment)
    @comment.attributes = comment_params
    @comment.save
  end

  def destroy
    @comment = Comments::Comment.find(params[:id])
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