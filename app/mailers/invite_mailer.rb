class InviteMailer < ActionMailer::Base
  include Resque::Mailer

  default :from => "no-reply@mythreebest.com"

  def invite_email(inviter, invited, invite)
    @inviter = inviter.full_name
    @invited = invited.first_name
    @message = invite[:message]
    @url = new_vote_url(inviter.id, :host => "m3b-staging.heroku.com")
    mail(:to => invite[:email], :subject => invite[:subject])
  end
end
