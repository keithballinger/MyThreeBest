require 'spec_helper'

describe FriendsController do

  describe "GET 'index'" do
    it "should return friends list" do
      user = Factory.create(:registered_user)
      sign_in user
      get 'index'
      response.should be_success
    end
  end

end
