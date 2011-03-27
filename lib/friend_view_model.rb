class FriendViewModel
  attr_accessor :name, :profile_image_url, :invite_status

  def initialize(user, friend)
    @name = friend.full_name
    @profile_image_url = friend.profile_picture
    invited = user.invited?(friend)
    voted = friend.voted?(user)
    if voted
        @link_text = "See votes"
        @link_url = "/votes/#{friend.id}"
    else
      if invited
        @link_text = "Re-Invite"
        @link_url = "/invite/#{friend.id}/new"
      else
        @link_text = "Invite"
        @link_url = "/invite/#{friend.id}/new"
      end
    end
  end
end
