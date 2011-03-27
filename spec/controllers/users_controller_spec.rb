require 'spec_helper'

describe UsersController do

  before(:each) do
    @user = Factory.create(:registered_user)
  end

  describe "GET 'index'" do
    it "should return friends list" do
      friend1 = Factory.create(:user)
      friend2 = Factory.create(:user)
      @user.friend(friend1)
      @user.friend(friend2)
      sign_in @user
      get 'index'
      response.should be_success
      assigns[:result].should_not be_nil
    end
  end

  describe "on #show" do

    it "should render user public page if user is showing photos to world" do
      sign_in @user
      get 'show', :public_page_url => @user.public_page_url

      assigns[:user].should == @user
      response.should render_template("users/show")
    end

    it "should redirect to index if user isn't showing photos to world" do
      @user.update_attribute(:public_page, false)
      sign_in @user
      get 'show', :public_page_url => @user.public_page_url

      response.should redirect_to(root_path)
    end
  end

  describe "on #update" do
    it "should set public page" do
      @user.update_attribute(:public_page, false)
      sign_in @user
      xhr :put, 'update', :id => @user.id, :user => {:public_page => true}

      @user.reload.public_page.should be_true
    end

    it "should unset public page" do
      sign_in @user
      xhr :put, 'update', :id => @user.id, :user => {:public_page => false}

      @user.reload.public_page.should be_false
    end
  end

end
