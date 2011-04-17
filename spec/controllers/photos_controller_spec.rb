require 'spec_helper'

describe PhotosController do

  describe "GET 'index'" do
    before(:each) do
      @user = Factory.create(:registered_user)
      sign_in @user
    end

    it "should be successful" do
      friend = Factory.create(:registered_user)
      @user.friend(friend)
      photos = create_photos_with_permissions(friend, 5, @user)
      xhr :get, 'index', :user_id => friend.id
      response.should be_success
    end
  end

end
