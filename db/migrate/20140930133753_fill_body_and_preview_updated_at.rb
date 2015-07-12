class FillBodyAndPreviewUpdatedAt < ActiveRecord::Migration
  def change
    Post.update_all('body_updated_at = updated_at, preview_updated_at = updated_at')
    Comment.update_all('body_updated_at = updated_at')
  end
end
