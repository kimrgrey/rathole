class FillPostsPublishedAt < ActiveRecord::Migration
  def change
    Post.published_only.find_each do |post|
      if post.published?
        post.published_at = post.created_at
        post.save!
      end
    end
  end
end
