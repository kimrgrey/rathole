xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    if @user.present?
      xml.title t('posts.rss.title_for_user', name: @user.user_name)
      xml.description @user.about_html
    else
      xml.title t('posts.rss.title_for_main')
      xml.description t('posts.rss.description_for_main')
    end
    xml.link url_for
    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description sanitize(post.preview_html)
        xml.pubDate post.published? ? post.published_at.to_s(:rfc822) : post.created_at.to_s(:rfc822)
        xml.link public_post_url(post)
        xml.guid public_post_url(post)
      end
    end
  end
end