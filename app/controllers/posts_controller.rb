class PostsController < ApplicationController
  respond_to :html, :json

  def index
    @posts = Post.all
    @posts = @posts.order('posts.created_at DESC')
    @posts = @posts.page(params[:page]).per(params[:per])
  end

  def show
    @post = Post.all.find(params[:id])
  end

  def new
    @post = Post.all.build
  end

  def create
    @post = Post.all.build(post_params)
    flash[:notice] = 'Congratulations! Post was successfully created!' if @post.save
    respond_with @post
  end

  def edit
    @post = Post.all.find(params[:id])
  end

  def update
    @post = Post.all.find(params[:id])
    flash[:notice] = 'Congratulations! Post was successfully saved!' if @post.update(post_params)
    respond_with @post
  end

  def destroy
    @post = Post.all.find(params[:id])
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
end