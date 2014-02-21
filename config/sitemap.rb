SitemapGenerator::Sitemap.default_host = "http://rathole.io"

SitemapGenerator::Interpreter.send :include, RoutesHelper
SitemapGenerator::Sitemap.create do  
  Post.published_only.find_each do |post|
    add public_post_path(post, only_path: true), lastmod: post.updated_at, priority: 0.7
  end

  User.all.find_each do |user|
    add public_profile_path(user, only_path: true), lastmod: user.updated_at
  end
end
