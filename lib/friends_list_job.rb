class FriendsListJob < Resque::JobWithStatus
  @queue = :friends_list

  def perform(params)

  end
end

