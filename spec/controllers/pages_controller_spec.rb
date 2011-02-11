require 'spec_helper'

describe PagesController do

  describe "on #index" do
    it "should render index page if user isn't logged" do
      get 'index'
      response.should render_template('index')
    end

    it "should render dashboard page if user is logged" do
      user = Factory.create(:user)
      sign_in user
      get 'index'
      response.should render_template('dashboard')
    end
  end

end
