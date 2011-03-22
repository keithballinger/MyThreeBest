class InviteMailer < ActionMailer::Base
  default :from => "no-reply@mythreebest.com"

  def invite_email(inviter, invited, email)
    @inviter = inviter.full_name
    @invited = invited.first_name
    @url = new_vote_url(inviter.id, :host => "m3b-staging.heroku.com")
    mail(:to => email, :subject => "Vote My Three Best Photos!!")
  end
end
