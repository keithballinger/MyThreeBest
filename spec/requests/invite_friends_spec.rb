require File.expand_path(File.dirname(__FILE__) + '/request_helper')

feature "Invite Friends", %q{
  In order to know Friends votes
  As an User
  I want to Invite my Friends
} do

  background do
    @user = create_user
    login_as @user 
  end

  scenario "Invite friends with a post in my wall" do
    pending
    #visit homepage
    #click_link 'Invite all my friends on my wall'
  end

  scenario "Invite friends with a email messages" do
    pending
  end

end
