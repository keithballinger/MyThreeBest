require 'spec_helper'

describe InvitesHelper do
  describe "on link_to_invite" do
    before(:each) do
      @user = Factory.create(:registered_user)
    end
    it "should display link if the user hasn't been invited" do
      friend = Factory.create(:user)
      @user.friend(friend)
      link_to_invite(@user, friend).should =~ /Invite/
    end
    it "should display 'Invited' if the user has been invited" do
      friend = Factory.create(:user)
      @user.friend(friend)
      @user.invite(friend)
      link_to_invite(@user, friend).should =~ /Invited/
    end
  end
end
