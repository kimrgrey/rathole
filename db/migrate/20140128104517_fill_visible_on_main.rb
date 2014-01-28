class FillVisibleOnMain < ActiveRecord::Migration
  def change
    Post.update_all(visible_on_main: false)
  end
end
