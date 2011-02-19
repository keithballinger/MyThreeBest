require 'spec_helper'

describe InvitesController do

  before(:each) do
    @user = Factory.create(:registered_user)
    sign_in @user
  end

  describe "on #new" do

    it "should retrieve a friend list" do
      @friends = []
      (0...5).each { u = Factory.create(:user) ; @user.friend(u) ; @friends << u}
      @user_job = @user.friends_list_job
      @user_job.stubs(:status).returns("completed")
      UserJob.any_instance.stubs(:first).returns(@user_job)

      xhr :get, :new
      assigns(:friends).should == @friends
      #assigns(:status).should == "completed"
    end

  end

  describe "on #create" do

    it "should create a new invitation" do
      friend = Factory.create(:user)
      @user.friend(friend)
      expect {
        xhr :post, :create, :user_id => friend.id
      }.to change(Invite, :count).by(1)
    end

  end

end
