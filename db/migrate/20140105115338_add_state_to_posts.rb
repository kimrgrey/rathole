class AddStateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :state, :integer, default: 0
    Post.reset_column_information
    Post.update_all(state: 0)
  end
end
