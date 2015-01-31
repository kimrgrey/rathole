namespace :fake do
  desc 'Generate fake posts'
  task :posts, [:user_id, :posts_count, :published, :on_main] => [ :environment ] do |t, args|
    args.with_defaults(:user_id => 1, :posts_count => 10)
    user = User.where(:id => args.user_id).first
    if user.blank?
      puts "User with id #{args.user_id} not found"
      return
    end
    args.posts_count.to_i.times do
      post = user.posts.build(:section => user.sections.first, :title => Faker::Lorem.sentence, :body => Faker::Lorem.paragraphs(20).join("\n\n"))
      post.save!
      post.toggle
    end
  end
end