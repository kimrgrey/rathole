class Api::V2::SyncController < Api::ApiController
  before_action :load_sync_dates, :except => [:claim]

  def start
    @sync = Sync.new(:lsd => @lsd, :next_lsd => @next_lsd)
    @sync.post = Post.with_deleted.published_and_hidden.find(params[:post_id]) if params[:post_id].present?
    saved = @sync.save
    respond_to do |format|
      if saved
        format.json { render :start }
      else
        format.json { head 400 }
      end
    end
  end

  def status
    @sync = Sync.find_by(:token => params[:token])
    if @sync.blank?
      respond_to do |format|
        format.json { head 400 }
      end
      return
    end
    @sync.attempt!
    respond_to do |format|
      format.json { render :status }
    end
  end

  def claim
    @post = posts.find_by(:id => params[:id])
    @claim = @post.claims.build(:body => params[:body])
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
end
