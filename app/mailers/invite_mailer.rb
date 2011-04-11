class InviteMailer < ActionMailer::Base
  include Resque::Mailer

  default :from => "no-reply@mythreebest.com"

  def invite_email(inviter_id, invited_id, invite_message, invite_email, invite_subject)
    @inviter = User.find(inviter_id).full_name
    @invited = User.find(invited_id).first_name
    @message = invite_message
    @url = new_vote_url(inviter_id, :host => "m3b-staging.heroku.com")
    mail(:to => invite_email, :subject => invite_subject)
  end
end
