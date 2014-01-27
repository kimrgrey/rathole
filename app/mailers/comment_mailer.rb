class CommentMailer < ActionMailer::Base
  add_template_helper(RoutesHelper)
  
  default from: Rails.application.secrets.mail_from

  def new_comment_posted(comment)
    @comment = comment
    @post = comment.post
    @author = comment.user
    @user = @post.user
    mail(to: @user.email, subject: I18n.t('comment_mailer.new_comment_posted.subject'))
  end
end
