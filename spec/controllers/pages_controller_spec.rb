require 'spec_helper'

describe PagesController do

  describe "on #index" do

    it "should render index page if user isn't logged" do
      get 'index'
      response.should render_template('index')
    end

    it "should render dashboard page if user is logged" do
      sign_in Factory.create(:registered_user)
      get 'index'
      response.should render_template('dashboard')
    end
  end

end
