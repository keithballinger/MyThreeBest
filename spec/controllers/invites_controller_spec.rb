require 'spec_helper'

describe InvitesController do

  before(:each) do
    @user = Factory.create(:registered_user)
    sign_in @user
  end

  describe "on #new" do

    it "should retrieve a friend list" do
      friend = Factory.create(:user)
      @user.friend(friend)

      get 'new', :user_id => friend.id
      assigns(:friends).should == @invited
      response.should render_template('new')
    end

  end

  describe "on #all" do
    it "should send a invitation to user facebook wall" do
      expect {
        xhr :get, :all
      }.to change(UserJob, :count).by(1)
    end
  end

end
