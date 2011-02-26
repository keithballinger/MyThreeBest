require 'spec_helper'

describe VotesController do

  describe "on #new" do
    before(:each) do
      @user = Factory.create(:registered_user)
      @voter = Factory.create(:registered_user)
    end

    it "should show vote page to voters if user is friend" do
      @user.friend(@voter)
      photos = []
      (1..5).each { photos << Factory.create(:photo, :user_id => @user.id) }

      sign_in @voter
      get 'new', :user_id => @user.id

      response.should render_template("votes/new")
      assigns(:photos).should == photos
    end

    it "should redirect to voter if isn't friend" do
      sign_in @voter
      get 'new', :user_id => @user.id

      response.should redirect_to(root_path)
    end
  end

  describe "on #create" do

    it "should create votes for user photos"

  end

end
