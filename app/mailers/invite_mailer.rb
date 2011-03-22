class InviteMailer < ActionMailer::Base
  default :from => "no-reply@mythreebest.com"

  def invite_email(inviter, invited, email)
    @inviter = inviter.full_name
    @invited = invited.first_name
    @url  = inviter.public_page_url
    mail(:to => email, :subject => "Vote My Three Best Photos!!")
  end
end
