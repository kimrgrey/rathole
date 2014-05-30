class AddLastPublishedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_published_at, :timestamp
  end
end
