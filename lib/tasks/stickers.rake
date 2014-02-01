namespace :stickers do 
  desc "Fill table with stickers without any warranty"
  task create_from_scratch: [:environment] do 
    Sticker.delete_all
    [Sticker::POST_NUMBER_1, Sticker::POST_NUMBER_10, Sticker::POST_NUMBER_100].each do |code|
      Sticker.create!(code: code, picture: "stickers/#{code}.png")
    end
  end

  desc "Distribute sticker for the first post"
  task post_number_1: [:environment] do 
    User.find_each do |user|
      if user.posts_count > 0 
        user.stickers << Sticker.with_code(Sticker::POST_NUMBER_1)
        user.save!
      end 
    end
  end
end