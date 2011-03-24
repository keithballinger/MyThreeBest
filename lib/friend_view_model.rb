class FriendViewModel
  attr_accessor :name, :profile_image_url, :invite_status

  def initialize(user, voted)
    @name = user.full_name
    @profile_image_url = user.profile_picture
    if voted
      @link_text = "See votes"
      @link_url = "/votes/#{user.id}"
    else
      @link_text = "Invite"
      @link_url = "/invite/#{user.id}"
    end
  end
end
