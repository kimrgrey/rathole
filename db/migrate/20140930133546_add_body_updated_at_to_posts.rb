class AddBodyUpdatedAtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :body_updated_at, :timestamp
  end
end
