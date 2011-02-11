require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Users Logout", %q{
  In order to finish using the page
  As a logged user
  I want to logout from the page
} do

  scenario "I logout from the page" do
    visit login_page
    visit logout_page
    page.should have_content('Login with Facebook')
  end
end
