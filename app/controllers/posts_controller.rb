class PostsController < ApplicationController  
  before_action :authenticate_user!

  authorize_actions_for Post, actions: {:publish => :update}
  
  before_action :load_user, except: [:publish]
  before_action :load_posts, except: [:publish]
  before_action :load_sections, only: [:new, :create, :edit, :update]
  before_action :load_section, only: [:create, :update]

  def index
    if params[:state] == :published
      @posts = @posts.published_only
    elsif params[:state] == :draft
      @posts = @posts.draft_only
    end
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
    @post = @posts.build
    @pictures = @user.pictures
  end

  def create
    @post = @posts.build(post_params)
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
    @post = @posts.find(params[:id])
    authorize_action_for(@post)
    @pictures = @user.pictures
  end

  def update
    @post = @posts.find(params[:id])
    authorize_action_for(@post)
    @post.attributes = post_params
    @post.section = @section
    if @post.save
      flash[:notice] = I18n.t('posts.update.success') 
      redirect_to user_post_path(@post)
    else
      @pictures = @user.pictures
      render :edit
    end
  end

  def destroy
    @post = @posts.find(params[:id])
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
    @post = Post.find(params[:id])
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
    @user = current_user
  end

  def load_posts
    @posts = @user.posts
  end

  def load_sections
    @sections = @user.sections
  end

  def load_section 
    @section = @sections.where(id: params[:post][:section_id]).first if params[:post][:section_id].present?
  end
end