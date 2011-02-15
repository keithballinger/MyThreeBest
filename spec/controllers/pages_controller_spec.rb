require 'spec_helper'

describe PagesController do

  describe "on #index" do

    it "should render index page if user isn't logged" do
      get 'index'
      response.should render_template('index')
    end

    it "should render dashboard page if user is logged" do
      stub_friends
      sign_in Factory.create(:user)
      get 'index'
      response.should render_template('dashboard')
    end
  end

end
