require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Users Login", %q{
  In order to start using the page
  As a potential user
  I want to login using my Facebook account
} do

  background do
    stub_facebook_profile
  end

  scenario "I login in the page" do
    visit login_page
    page.should have_content('John')
    page.should have_content('Logout')
  end
end
