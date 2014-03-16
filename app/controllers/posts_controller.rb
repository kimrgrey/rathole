class PostsController < ApplicationController  
  before_action :authenticate_user!, except: [:index, :show]

  authorize_actions_for Post, actions: {:publish => :update}
  
  before_action :load_user, only: [:index, :show]
  before_action :load_posts, only: [:index, :show]
  before_action :load_sections, only: [:new, :create, :edit, :update]

  def index
    @posts = @posts.tagged_with(params[:tag]) if params[:tag].present?
    @posts = @posts.visible_on_main unless @user
    @posts = @posts.in_order
    @posts = @posts.page(params[:page]).per(params[:per])
  end

  def show
    @post = @posts.find(params[:id])
    authorize_action_for(@post)
    @comments = @post.comments
    @comments = @comments.includes(:user)
    @comments = @comments.in_order
    @comments = @comments.page(params[:page]).per(params[:per])
  end

  def new
    @post = current_user.posts.build
    @pictures = current_user.pictures
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.section = @section
    if @post.save
      flash[:notice] = I18n.t('posts.create.success') 
      redirect_to user_post_path(@post)
    else
      @pictures = @user.pictures
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
    authorize_action_for(@post)
    @pictures = current_user.pictures
  end

  def update
    @post = current_user.posts.find(params[:id])
    authorize_action_for(@post)
    @post.attributes = post_params
    @post.section = @section
    if @post.save
      flash[:notice] = I18n.t('posts.update.success') 
      redirect_to user_post_path(@post)
    else
      @pictures = current_user.pictures
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    authorize_action_for(@post)
    if @post.destroy
      flash[:notice] = I18n.t('posts.destroy.success')
      redirect_to user_posts_path
    else
      flash[:error] = @section.errors[:base].any? ? @section.errors[:base].join : I18n.t('posts.destroy.failed')
      redirect_to :back
    end
  end

  def publish
    @post = current_user.posts.find(params[:id])
    authorize_action_for(@post)
    if @post.toggle
      flash[:notice] = I18n.t("posts.publish.#{@post.state}.success")
    else
      flash[:error] =  I18n.t("posts.publish.#{@post.state}.failed")
    end
    redirect_to user_post_path(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :tag_list)
  end

  def load_user
    @user = User.find_by(user_name: params[:user_name]) if params[:user_name].present?
  end

  def load_posts
    if @user
      @posts = @user.posts
      @posts = @posts.published_only if user_signed_in? && current_user != @user
    else
      @posts = user_signed_in? ? Post.my_or_published(current_user) : Post.published_only
    end
    @posts = @posts.joins(:section).where(section_id: params[:section_id]) if params[:section_id].present?
  end

  def load_sections 
    @sections = current_user.sections
    @section = @sections.find(params[:post][:section_id]) if params[:post].present? && params[:post][:section_id].present?
  end
end