class Api::V1::SyncController < Api::ApiController
  before_action :load_sync_dates, except: [:claim]

  def sync
    @users = User.recently_updated(@lsd, @next_lsd)
    @users = @users.in_order
    @posts = posts.recently_updated(@lsd, @next_lsd)
    @posts = @posts.in_order
    respond_to do |format|
      format.json { render :sync }
    end
  end

  def post
    @post = posts.find_by(id: params[:id])
    @users = User.recently_updated(@lsd, @next_lsd)
    @users = @users.where(id: [@post.user_id] + @post.comments.map(&:user_id))
    @users = @users.in_order
    respond_to do |format|
      format.json { render :post }
    end
  end

  def claim
    @post = posts.find_by(id: params[:id])
    @claim = @post.claims.build(body: params[:body])
    saved = @claim.save
    respond_to do |format|
      format.json { head (saved ? 200 : 400) }
    end
  end

  private

  def load_sync_dates
    @lsd = Time.at(params[:lsd].to_i)
    @next_lsd = Time.now
  end

  def posts
    Post.with_deleted.published_and_hidden
  end
end