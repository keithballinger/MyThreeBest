require 'spec_helper'

describe SessionsController do

  describe "on #create" do

      before(:each) do
        @creds = OmniAuth.config.mock_auth[:facebook]
        request.env['omniauth.auth'] = @creds
      end

      it "should create and login to a new user" do
        expect do
          get :create, :provider => "facebook"
        end.to change(User, :count).by(1)
        response.should redirect_to(root_path)
        assigns(:user).should eq(User.last)
      end

      it "should login to user if already created" do
        user = User.create_with_omniauth(@creds)
        expect do
          get :create, :provider => "facebook"
        end.to change(User, :count).by(0)
        response.should redirect_to(root_path)
        assigns(:user).should eq(User.last)
      end

  end
end
