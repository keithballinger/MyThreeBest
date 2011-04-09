class FriendsList < Resque::JobWithStatus
  @queue = :friends_list

  def perform
    me = User.find(options['user_id'])
    me.friends_list_job.update_attributes(:status => "working")
    graph = Koala::Facebook::GraphAPI.new(me.facebook_token)
    friends = graph.get_connections("me", "friends")
    total = friends.count
    num = 1
    friends.each do |friend|
      at(num, total, "Looking at user #{num} of #{total}")
      user = User.find_by_facebook_uid(friend['id'])
      if user
        me.friend(user) unless me.friend?(user.facebook_uid)
      else
        info = graph.get_object(friend['id'])
        photo = graph.get_picture(friend['id'])
        begin
          user = User.create!(:first_name => info['first_name'], :last_name => info['last_name'],
                           :facebook_uid => friend['id'], :profile_picture => photo)
          me.friend(user) unless me.friend?(user.facebook_uid)
        rescue
          Rails.logger.error("Failed to save user: #{user.inspect}")
        end
      end
      num += 1
    end
    me.friends_list_job.update_attributes(:status => "completed")
    completed
  end
end

