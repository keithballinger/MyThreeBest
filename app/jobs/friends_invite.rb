class FriendsInvite < Resque::JobWithStatus
  @queue = :friends_invite

  def perform
    inviter = User.find(options['inviter_id'])
    invited = User.find(options['invited_id'])
    invite = options['invite']
    InviteMailer.invite_email(inviter, invited, invite).deliver
  end
end
