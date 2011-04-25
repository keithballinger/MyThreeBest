class FriendViewModel
  def initialize(user, friend1, friend2)
    right_row(user, friend1)
    left_row(user, friend2) if friend2
  end

  def right_row(user, friend)
    @right_name = friend.full_name
    @right_profile_image_url = friend.profile_picture
    invited = user.invited?(friend)
    voted = friend.voted?(user)
    if voted
        @right_link_text = "See votes"
        @right_link_url = "/votes/#{friend.id}"
    else
      if invited
        @right_link_text = "Re-Invite"
        @right_link_url = "/invite/#{friend.id}/new"
      else
        @right_link_text = "Invite"
        @right_link_url = "/invite/#{friend.id}/new"
      end
    end
  end

  def left_row(user, friend)
    @left_name = friend.full_name
    @left_profile_image_url = friend.profile_picture
    invited = user.invited?(friend)
    voted = friend.voted?(user)
    if voted
        @left_link_text = "See votes"
        @left_link_url = "/votes/#{friend.id}"
    else
      if invited
        @left_link_text = "Re-Invite"
        @left_link_url = "/invite/#{friend.id}/new"
      else
        @left_link_text = "Invite"
        @left_link_url = "/invite/#{friend.id}/new"
      end
    end
  end
end
