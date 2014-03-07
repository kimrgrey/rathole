namespace :stickers do 
  desc "Fill table with stickers without any warranty"
  task create_from_scratch: [:environment] do 
    Sticker.delete_all
    Sticker.codes.each { |code| Sticker.create!(code: code, picture: "stickers/#{code}.png") }
  end

  desc "Distribute stickers for 1 post"
  task post_number_1: [:environment] do 
    Rails.logger.info "Distribute stickers for 1 post..."
    sticker = Sticker.with_code(Sticker::POST_NUMBER_1)
    if sticker
      User.where('users.posts_count >= ?', 1).find_each { |user| user.assign_sticker!(sticker) }
    end
  end

  desc "Distribute stickers for 10 posts"
  task post_number_10: [:environment] do 
    Rails.logger.info "Distribute stickers for 10 post..."
    sticker = Sticker.with_code(Sticker::POST_NUMBER_10)
    if sticker
      User.where('users.posts_count >= ?', 10).find_each { |user| user.assign_sticker!(sticker) }
    end
  end

  desc "Distribute sticker for 100 posts"
  task post_number_100: [:environment] do 
    Rails.logger.info "Distribute stickers for 100 post..."
    sticker = Sticker.with_code(Sticker::POST_NUMBER_100)
    if sticker
      User.where('users.posts_count >= ?', 100).find_each { |user| user.assign_sticker!(sticker) }
    end
  end

  desc "Distribute stickers to best authors"
  task best_author: [:environment] do 
    Rails.logger.info "Distribute stickers to best authors..."
    sticker = Sticker.with_code(Sticker::BEST_AUTHOR)
    if sticker
      max_posts_count = User.maximum(:posts_count) || 0
      User.joins(:stickers).where('users.posts_count < ?', max_posts_count).where(stickers: {code: Sticker::BEST_AUTHOR}).find_each { |user| user.remove_sticker!(sticker) }
      User.where(posts_count: max_posts_count).find_each { |user| user.assign_sticker!(sticker) }
    end
  end

  desc "Distribute stickers to best commentators"
  task best_commentator: [:environment] do 
    Rails.logger.info "Distribute stickers to best commentators..."
    sticker = Sticker.with_code(Sticker::BEST_COMMENTATOR)
    if sticker
      max_comments_count = User.maximum(:comments_count) || 0
      User.joins(:stickers).where('users.comments_count < ?', max_comments_count).where(stickers: {code: Sticker::BEST_COMMENTATOR}).find_each { |user| user.remove_sticker!(sticker) }
      User.where(comments_count: max_comments_count).find_each { |user| user.assign_sticker!(sticker) }
    end
  end

  desc "Distribute stickers to best correctors"
  task best_corrector: [:environment] do 
    Rails.logger.info "Distribute stickers to best correctors..."
    sticker = Sticker.with_code(Sticker::BEST_CORRECTOR)
    if sticker
      max_bugs_count = User.maximum(:bugs_count) || 0
      User.joins(:stickers).where('users.bugs_count < ?', max_bugs_count).where(stickers: {code: Sticker::BEST_CORRECTOR}).find_each { |user| user.remove_sticker!(sticker) }
      User.where(bugs_count: max_bugs_count).find_each { |user| user.assign_sticker!(sticker) }
    end
  end

  desc "Distribute all stickers"
  task distribute: [:environment] do 
    Sticker.codes.each { |code| Rake::Task["stickers:#{code}"].invoke }
  end
end