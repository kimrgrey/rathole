class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user
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
      redirect_to user_post_path(@post)
    else
      render :new
    end
  end

  def edit
    logger.info @posts.to_a
    @post = @posts.find(params[:id])
  end

  def update
    @post = @posts.find(params[:id])
    @post.attributes = post_params
    @post.section = @section
    if @post.save
      flash[:notice] = I18n.t('posts.update.success') 
      redirect_to user_post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = @posts.find(params[:id])
    if @post.destroy
      flash[:notice] = I18n.t('posts.destroy.success')
      redirect_to user_posts_path
    else
      flash[:error] = @section.errors[:base].any? ? @section.errors[:base].join : I18n.t('posts.destroy.failed')
      redirect_to :back
    end
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