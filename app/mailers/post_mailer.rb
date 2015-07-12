class PostMailer < ActionMailer::Base
  add_template_helper(RoutesHelper)
  add_template_helper(PostsHelper)

  default from: Rails.application.secrets.mail_from

  def notify_subscriber_about_comment(subscriber, comment)
    @subscriber = subscriber
    @comment = comment
    @post = comment.parent
    @author = comment.user
    mail(to: @subscriber.email, subject: I18n.t('post_mailer.notify_subscriber_about_comment.subject')) unless @subscriber == @author
  end

  def notify_admin_about_post(post, admin)
    @post = post
    @author = post.user
    @user = admin
    mail(to: @user.email, subject: I18n.t('post_mailer.notify_admin_about_post.subject')) unless @author == @admin
  end

  def notify_subscriber_about_post(post, subscriber)
    @post = post
    @author = post.user
    @subscriber = subscriber
    mail(to: @subscriber.email, subject: I18n.t('post_mailer.notify_admin_about_post.subject')) unless @author == @subscriber
  end
end
