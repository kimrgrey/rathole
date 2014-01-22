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

  desc "Exctracts preview for all posts"
  task extract_preview: [:environment] do 
    Post.find_each do |post|
      post.extract_preview_from_body!(true)
      post.convert_preview_to_html!(true)
      post.save!
    end
  end 

  desc "Converts markdown to html for all posts and comments"
  task convert_body: [:environment] do 
    Post.find_each do |post|
      post.convert_body_to_html!(true)
      post.save!
    end
    Comment.find_each do |comment|
      comment.convert_body_to_html!(true)
      comment.save!
    end
  end
end
