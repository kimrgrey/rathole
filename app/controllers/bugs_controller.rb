class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user

  def index
    @bugs = Bug.for_author(@user)
    @bugs = @bugs.where(post_id: params[:post_id]) if params[:post_id].present?
    @bugs = @bugs.in_order
    @bugs = @bugs.page(params[:page]).per(params[:per])
  end

  def show
    @bug = Bug.for_author(@user).find(params[:id])
  end
    
  def create
    @post = Post.published_only.find(params[:post_id])
    @bug = @post.bugs.build(reporter_id: @user.id, note: params[:note])
    @bug.fragment = params[:fragment] if params[:fragment].present?
    if @bug.save
      flash[:notice] = I18n.t('bugs.create.success')
    else
      flash[:error] = I18n.t('bugs.create.failed')
    end
    redirect_to :back
  end

  private

  def load_user
    @user = current_user
  end
end