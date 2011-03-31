require 'spec_helper'

describe VotesController do

  before(:each) do
    @user = Factory.create(:registered_user)
    @voter = Factory.create(:registered_user)
  end

  describe "on #new" do

    it "should show vote page to voters if user is friend" do
      @user.friend(@voter)
      photos = create_photos_with_permissions(@user, 5, @voter)
      sign_in @voter
      get 'new', :user_id => @user.id

      response.should render_template("votes/new")
      assigns(:photos).should == photos
    end

    it "should show vote page to voters with their current votes" do
      @user.friend(@voter)
      photos = create_photos_with_permissions(@user, 3, @voter)
      @voter.vote(photos)
      sign_in @voter
      get 'new', :user_id => @user.id

      assigns(:first_voted).should_not be_nil
      assigns(:second_voted).should_not be_nil
      assigns(:third_voted).should_not be_nil
    end

    it "should redirect to voter if isn't friend" do
      sign_in @voter
      get 'new', :user_id => @user.id

      response.should redirect_to(root_path)
    end
  end

  describe "on #create" do

    it "should create votes for user photos" do
      @user.friend(@voter)
      photo = create_photos_with_permissions(@user, 1, @voter).first
      sign_in @voter
      expect {
        post 'create', :user_id => @user.id, :vote => [photo.id]
      }.to change(photo.votes, :count).by(1)
    end
  end

  describe "on #delete" do
    it "should remove a user vote" do
      @user.friend(@voter)
      photo = create_photos_with_permissions(@user, 1, @voter).first
      @voter.vote([photo])

      sign_in @voter
      expect {
        delete 'destroy', :user_id => @user.id, :photo_id => photo.id
      }.to change(Vote, :count).by(-1)
    end
  end

  describe "on #index" do
    it "should show all my photos with votes" do
      @user.friend(@voter)
      photo = create_photos_with_permissions(@user, 1, @voter).first
      @voter.vote([photo])
      sign_in @user
      get 'index'
      assigns[:photos].should == [photo]
    end
  end

  describe "on #show" do
    it "should display the photos voted by a friend" do
      @user.friend(@voter)
      photo = create_photos_with_permissions(@user, 1, @voter).first
      @voter.vote([photo])
      sign_in @user
      get 'show', :user_id => @voter.id
      assigns[:user].should == @voter
      assigns[:voted_photos].should == [photo] 
    end
  end

end
