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

  desc "Recreates versions for all avatars"
  task recreate_avatars: [:environment] do
    User.find_each do |user|
      user.avatar.recreate_versions! if user.avatar.present?
    end
  end

  desc "Subscribe authors on their posts"
  task subscribe_authors: [:environment] do
    Post.find_each do |post|
      post.subscribe_author!
    end
  end

  desc "Subscribe commentators on posts"
  task subscribe_commentators: [:environment] do
    Post.find_each do |post|
      post.subscribe_commentators!
    end
  end

  desc "Collects statistical data"
  task collect_statistic: [:environment] do 
    date = Time.zone.today - 1.day
    StatisticalRecord.collect_and_save!(date) if StatisticalRecord.find_by(date: date).nil?
  end
end
