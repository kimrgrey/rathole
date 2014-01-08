class AddPreviewToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :preview, :text
    add_column :posts, :preview_html, :text
  end
end
