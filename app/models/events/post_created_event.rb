class Events::PostCreatedEvent < Events::Event
  hstore :properties, :post, 'Post'
  hstore :properties, :author, 'User'

  after_create :send_mail_to_admins
  
  def send_mail_to_admins
    User.admins.each do |admin| 
      PostMailer.new_post_created(post, admin).deliver if admin != author
    end
  end
end