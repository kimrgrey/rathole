class BugMailer < ActionMailer::Base
  add_template_helper(RoutesHelper)
  add_template_helper(PostsHelper)
  
  default from: Rails.application.secrets.mail_from

  def notify_author_about_bug(bug)
    @bug = bug
    @post = bug.post
    @reporter = bug.reporter
    @author = @post.user
    mail(to: @author.email, subject: I18n.t('bug_mailer.notify_author_about_bug.subject'))
  end

  def notify_reporter_about_fixed_bug(bug)
    @bug = bug
    @post = bug.post
    @reporter = bug.reporter
    @author = @post.user
    mail(to: @reporter.email, subject: I18n.t('bug_mailer.notify_reporter_about_fixed_bug.subject'))
  end

  def notify_reporter_about_rejected_bug(bug)
    @bug = bug
    @post = bug.post
    @reporter = bug.reporter
    @author = @post.user
    mail(to: @reporter.email, subject: I18n.t('bug_mailer.notify_reporter_about_rejected_bug.subject'))
  end
end