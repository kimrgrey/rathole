class AddVisibleOnMainToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :visible_on_main, :boolean, default: false
  end
end
