class FriendsInvite < Resque::JobWithStatus
  @queue = :friends_invite

  def perform
    inviter = User.find(options['inviter_id'])
    invited = User.find(options['invited_id'])
    graph = Koala::Facebook::GraphAPI.new(inviter.facebook_token)
    graph.put_wall_post("Vote for My Three Best Photos!! http://m3b-staging.heroku.com/link",
                        {:name => "m3b", :link => "http://m3b-staging.heroku.com/link"}, invited.facebook_uid)
  end
end
