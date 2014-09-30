class AddPreviewUpdatedAtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :preview_updated_at, :timestamp
  end
end
