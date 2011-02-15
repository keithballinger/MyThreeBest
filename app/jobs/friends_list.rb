class FriendsList < Resque::JobWithStatus
  @queue = :friends_list

  def perform(params)
    graph = Koala::Facebook::GraphAPI.new(params[:facebook_token])
    friends = graph.get_connections("me", "friends")
    friends.each do |friend|
      user = User.find_by_facebook_uid(friend['id'])
      if user
        me.friend(friend) unless me.friend?(friend)
      else
        info = graph.get_object(friend['id'])
        user = User.create!(:first_name => info['first_name'], :last_name => info['last_name'],
                            :facebook_uid => friend['id'])
        me.friend(user)
      end
    end
  end
end

