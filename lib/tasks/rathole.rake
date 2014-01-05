namespace :rathole do
  desc "Updates cache of counters for all models"
  task update_counters: [ :environment ] do
    User.find_each do |user|
      User.reset_counters(user.id, :comments)
      User.reset_counters(user.id, :posts)
    end
    Post.find_each do |post|
      Post.reset_counters(post.id, :comments)
    end
    Section.find_each do |section|
      Section.reset_counters(section.id, :posts)
    end
  end
end
