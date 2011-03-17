require 'spec_helper'

describe UsersController do

  before(:each) do
    @user = Factory.create(:registered_user)
  end

  describe "on #show" do

    it "should render user public page if user is showing photos to world" do
      get 'show', :full_name => "#{@user.first_name}_#{@user.last_name}"

      assigns[:user].should == @user
      response.should render_template("users/show")
    end

    it "should redirect to index if user isn't showing photos to world" do
      @user.update_attribute(:public_page, false)
      get 'show', :full_name => "#{@user.first_name}_#{@user.last_name}"

      response.should redirect_to(root_path)
    end
  end

end
