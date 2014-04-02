class Admin::DashboardController < Admin::AdminController
  before_action :load_user
  
  def home
    @users = User.all
    @users = @users.order(:created_at => :desc)
    @users = @users.page(params[:users_page]).per(params[:per])
    @posts = Post.all
    @posts = @posts.order(:created_at => :desc)
    @posts = @posts.page(params[:posts_page]).per(params[:per])
  end

  def statistics
    records = StatisticalRecord.order(:date)
    records = records.limit(params[:limit].to_i) if params[:limit].present?
    events = records.map { |event| [event.date.to_time.to_i * 1000, event.events_count] }
    users = records.map { |event| [event.date.to_time.to_i * 1000, event.users_count] }
    posts = records.map { |event| [event.date.to_time.to_i * 1000, event.posts_count] }
    comments = records.map { |event| [event.date.to_time.to_i * 1000, event.comments_count] }
    @data = [
      { color: 'red', name: 'events_count', values: events },
      { color: 'blue', name: 'posts_count', values: posts },
      { color: 'yellow', name: 'users_count', values: users },
      { color: 'purple', name: 'comments_count', values: comments }
    ]
  end

  private

  def load_user
    @user = current_user
  end
end