require 'spec_helper'

describe FriendsController do

  describe "GET 'index'" do
    it "should return friends list" do
      sign_in Factory.create(:user)
      get 'index'
      response.should be_success
    end
  end

end
