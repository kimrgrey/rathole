class Api::V1::SyncController < Api::ApiController
  before_action :load_sync_dates
  before_action :load_post, only: [:post]

  def sync
    @users = User.recently_updated(@lsd, @next_lsd)
    @users = @users.in_order
    @posts = Post.published_only.recently_updated(@lsd, @next_lsd)
    @posts = @posts.in_order
  end

  def post
    @users = User.recently_updated(@lsd, @next_lsd)
    @users = @users.where(id: @post.comments.map(&:user_id))
    @users = @users.in_order
  end

  private

  def load_sync_dates
    @lsd = Time.at(params[:lsd].to_i)
    @next_lsd = Time.now
  end

  def load_post
    @post = Post.published_only.find_by(id: params[:id])
  end
end