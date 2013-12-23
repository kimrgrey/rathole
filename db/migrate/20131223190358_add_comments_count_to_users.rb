class AddCommentsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :comments_count, :integer, default: 0
    User.reset_column_information
    User.find_each do |user|
      User.update_counters user.id, :comments_count => user.comments.length
    end

  end
end
