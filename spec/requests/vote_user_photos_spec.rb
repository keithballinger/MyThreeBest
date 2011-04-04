require File.expand_path(File.dirname(__FILE__) + '/request_helper')

feature "Vote User Photos", %q{
  In order to know best friends photos
  As an User
  I want to vote my friends photos
} do

  background do
    stub_facebook_profile
    @voter = create_user
    @friend = create_user
    @voter.friend(@friend)
    @photos = create_photos_with_permissions(@friend, 3, @voter)
    login_as @voter
  end

  scenario "I vote photos of a friend", :driver => :selenium do
    visit vote_user_page(@friend)
    click_link 'Select photo'
    click_button 'Click Here When Finished'

    page.should have_content("Thanks!")
  end
end
