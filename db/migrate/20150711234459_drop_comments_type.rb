class DropCommentsType < ActiveRecord::Migration
  def change
    remove_column :comments, :type
  end
end
