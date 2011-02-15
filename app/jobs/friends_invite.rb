class FriendsInvite < Resque::JobWithStatus
  @queue = :friends_invite

  def perform(params)

  end
end
