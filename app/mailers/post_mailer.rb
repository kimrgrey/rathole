class PostMailer < ActionMailer::Base
  add_template_helper(RoutesHelper)
  
  default from: Rails.application.secrets.mail_from

  def new_comment_created(comment)
    @comment = comment
    @post = comment.post
    @author = comment.user
    @user = @post.user
    mail(to: @user.email, subject: I18n.t('post_mailer.new_comment_created.subject'))
  end

  def new_post_created(post, admin)
    @post = post
    @author = post.user
    @user = admin
    mail(to: @user.email, subject: I18n.t('post_mailer.new_post_created.subject')) 
  end
end
