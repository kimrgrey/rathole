class PostsController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_current_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_other_user, only: [:index, :show]
  before_action :load_posts

  def index
    @posts = @posts.order('posts.created_at DESC')
    @posts = @posts.page(params[:page]).per(params[:per])
  end

  def show
    @post = @posts.find(params[:id])
  end

  def new
    @post = @posts.build
  end

  def create
    @post = @posts.build(post_params)
    flash[:notice] = 'Congratulations! Post was successfully created!' if @post.save
    respond_with @post
  end

  def edit
    @post =@posts.find(params[:id])
  end

  def update
    @post = @posts.find(params[:id])
    flash[:notice] = 'Congratulations! Post was successfully saved!' if @post.update(post_params)
    respond_with @post
  end

  def destroy
    @post = @posts.find(params[:id])
    if @post.destroy
      flash[:notice] = "Congratulations! Post was successfully deleted!"
    else
      flash[:error] = "Sorry! Failed to delete post!"
    end
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def load_other_user
    if params[:user_name].present?
      @user = User.where(user_name: params[:user_name]).first || not_found
    else
      @user = current_user
    end
  end

  def load_current_user
    @user = current_user
  end

  def load_posts
    @posts = @user.posts
  end
end