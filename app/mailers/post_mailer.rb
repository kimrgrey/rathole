class PostMailer < ActionMailer::Base
  add_template_helper(RoutesHelper)
  add_template_helper(PostsHelper)
  
  default from: Rails.application.secrets.mail_from

  def notify_subscriber_about_comment(subscriber, comment)
    @subscriber = subscriber
    @comment = comment
    @post = comment.post
    @author = comment.user
    mail(to: @subscriber.email, subject: I18n.t('post_mailer.notify_subscriber_about_comment.subject')) unless @subscriber == @author
  end

  def new_post_created(post, admin)
    @post = post
    @author = post.user
    @user = admin
    mail(to: @user.email, subject: I18n.t('post_mailer.new_post_created.subject')) unless @author == @admin
  end
end
