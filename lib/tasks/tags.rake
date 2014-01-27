namespace :tags do
  desc "Delete trailing spaces from tags"
  task strip: [ :environment ] do
    Post.find_each do |post|
      post.tag_list = post.tag_list
      post.save!
    end
  end
end