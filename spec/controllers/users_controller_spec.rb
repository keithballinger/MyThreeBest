require 'spec_helper'

describe UsersController do

  before(:each) do
    @user = Factory.create(:registered_user)
  end

  describe "on #show" do

    it "should render user public page if user is showing photos to world" do
      get 'show', :public_page_url => @user.public_page_url

      assigns[:user].should == @user
      response.should render_template("users/show")
    end

    it "should redirect to index if user isn't showing photos to world" do
      @user.update_attribute(:public_page, false)
      get 'show', :public_page_url => @user.public_page_url

      response.should redirect_to(root_path)
    end
  end

  describe "on #update" do
    it "should set public page" do
      pending
      @user.update_attribute(:public_page, false)
      sign_in @user
      xhr :put, 'update', :public_page => true

      @user.public_page.should be_true
    end

    it "should unset public page" do
      pending
      sign_in @user
      xhr :put, 'update', :public_page => false

      @user.public_page.should be_false
    end
  end

end
