class AddTagsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :tags, :text, array: true, default: '{}'
    Post.reset_column_information
    Post.find_each do |post|
      post.tags = []
      post.save!
    end
    add_index :posts, :tags, using: 'gin'
  end
end
