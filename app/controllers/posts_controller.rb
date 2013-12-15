class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_current_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_other_user, only: [:index, :show]
  before_action :load_posts
  before_action :load_sections, only: [:new, :create, :edit, :update]
  before_action :load_section, only: [:create, :update]

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
    @post.section = @section
    if @post.save
      flash[:notice] = I18n.t('posts.create.success') 
      redirect_to profile_post_path(@user.user_name, @post)
    else
      render :new
    end
  end

  def edit
    @post =@posts.find(params[:id])
  end

  def update
    @post = @posts.find(params[:id])
    @post.attributes = post_params
    @post.section = @section
    if @post.save
      flash[:notice] = I18n.t('posts.update.success') 
      redirect_to profile_post_path(@user.user_name, @post)
    else
      render :edit
    end
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
    params.require(:post).permit(:title, :body, :tag_list)
  end

  def load_other_user
    @user = User.where(user_name: params[:user_name]).first || not_found if params[:user_name].present?
  end

  def load_current_user
    @user = current_user
  end

  def load_posts
    @posts = @user ? @user.posts : Post.all
  end

  def load_sections
    @sections = @user.sections
  end

  def load_section 
    @section = @sections.where(id: params[:post][:section_id]).first if params[:post][:section_id].present?
  end
end