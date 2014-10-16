class AddUsersAboutUpdatedAt < ActiveRecord::Migration
  def change
    add_column :users, :about_updated_at, :timestamp
  end
end
