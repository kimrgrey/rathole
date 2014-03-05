class Admin::PostsController < Admin::AdminController
  before_action :load_post

  def show
    @comments = @post.comments
    @comments = @comments.in_order
    @comments = @comments.page(params[:page]).per(params[:per])
  end

  def show_on_main
    if @post.show_on_main
      flash[:notice] = I18n.t('admin.posts.show_on_main.success')
    else
      flash[:error] = I18n.t('admin.posts.show_on_main.failed')
    end
    redirect_to :back
  end

  def hide_from_main
    if @post.hide_from_main
      flash[:notice] = I18n.t('admin.posts.hide_from_main.success')
    else
      flash[:error] = I18n.t('admin.posts.hide_from_main.failed')
    end
    redirect_to :back
  end

  def destroy
    if @post.destroy
      flash[:notice] = I18n.t('admin.posts.destroy.success')
      redirect_to admin_root_path
    else
      flash[:error] = I18n.t('admin.posts.destroy.failed')
      redirect_to admin_post_path(@post)
    end
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end
end