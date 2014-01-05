namespace :rathole do
  desc "Updates cache of counters for all models"
  task update_counters: [ :environment ] do
    User.find_each do |user|
      User.update_counters user.id, :comments_count => user.comments.length
      User.update_counters user.id, :posts_count => user.posts.length
    end
    Post.find_each do |post|
      Post.update_counters post.id, :comments_count => post.comments.length
    end
    Section.find_each do |section|
      Section.update_counters section.id, :posts_count => section.posts.length
    end
  end
end
