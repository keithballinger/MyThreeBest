module InvitesHelper
  def link_to_invite(user, friend)
    if user.invited?(friend)
      "<strong>Invited</strong>".html_safe
    else
      link_to "Invite", invite_friend_path(:user_id => friend.id), :remote => true
    end
  end
end
