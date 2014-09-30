class AddBodyUpdatedAtToComments < ActiveRecord::Migration
  def change
    add_column :comments, :body_updated_at, :timestamp
  end
end
