class Admin::DashboardController < Admin::AdminController
  before_action :load_user
  
  def home
    @users = User.all
    @users = @users.order(:created_at => :desc)
    @users = @users.page(params[:page]).per(params[:per])
    @posts = Post.all
    @posts = @posts.order(:created_at => :desc)
    @posts = @posts.page(params[:page]).per(params[:per])
  end

  private

  def load_user
    @user = current_user
  end
end