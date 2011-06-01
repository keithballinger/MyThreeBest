require File.expand_path(File.dirname(__FILE__) + '/request_helper')

feature "Users Logout", %q{
  In order to finish using the page
  As a logged user
  I want to logout from the page
} do

  background do
    stub_facebook_profile
    visit login_page
    #login_as Factory.create(:user)
  end

  scenario "I logout from the page" do
    pending
    visit logout_page
    page.should have_content('Login with Facebook')
    page.current_path.should == homepage
  end
end
