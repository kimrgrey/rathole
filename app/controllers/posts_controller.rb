class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user
  before_action :load_posts
  before_action :load_sections, only: [:new, :create, :edit, :update]
  before_action :load_section, only: [:create, :update]

  def index
    @posts = @posts.in_order
    @posts = @posts.page(params[:page]).per(params[:per])
  end

  def show
    @post = @posts.find(params[:id])
    @comments = @post.comments
    @comments = @comments.in_order
    @comments = @comments.page(params[:page]).per(params[:per])
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
    @post = @posts.find(params[:id])
  end

  def update
    @post = @posts.find(params[:id])
    @post.attributes = post_params
    @post.section = @section
    if @post.save
      invalidate_post_caches(@post)
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

  def comment
    @post = @posts.find(params[:id])
    @comment = @post.comments.build(comment_params)
    @comment.user = @user
    if @comment.save
      flash[:notice] = I18n.t('posts.comment.success')
    else
      flash[:error] = I18n.t('posts.comment.failed')
    end
    redirect_to :back
  end

  private

  def invalidate_post_caches(post)
    editable, preview = [true, false], [true, false]
    editable.product(preview).each do |preview, editable|
      expire_fragment("post-#{post.id}-#{preview}-#{editable}")
    end
  end

  def comment_params
    params.permit(:body)
  end

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