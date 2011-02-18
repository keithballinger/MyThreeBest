require 'spec_helper'

describe InvitesController do

  describe "on #new" do
    before do
      @user = Factory.create(:registered_user)
      @friends = []
      (0...5).each { u = Factory.create(:user) ; @user.friend(u) ; @friends << u}
      @user_job = @user.user_jobs.where(:job_type => "friends_list").first
      @user_job.stubs(:status).returns("completed")
      UserJob.any_instance.stubs(:first).returns(@user_job)
      sign_in @user
    end

    it "should retrieve a friend list" do
      xhr :get, :new
      assigns(:friends).should == @friends
      #assigns(:status).should == "completed"
    end

  end

  describe "on #create" do
    it "should create a new invitation"
  end

end
