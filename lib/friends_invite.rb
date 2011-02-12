class FriendsInviteJob < Resque::JobWithStatus
  @queue = :friends_invite_job

  def perform(params)

  end
end
