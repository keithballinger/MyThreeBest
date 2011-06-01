require File.expand_path(File.dirname(__FILE__) + '/request_helper')

feature "Show User Photos Feature", %q{
  In order to vote in friends photos
  As an User
  I want to see the photos of my friends
} do

  background do
    stub_facebook_profile
    @voter = create_user
    login_as @voter
  end

  scenario "I visit the votes page of a friend" do
    pending
    friend = create_user
    @voter.friend(friend)
    visit vote_user_page(friend)

    page.should have_content("Photos of #{friend.first_name}")
    page.should have_content("Select a photo")
  end

  scenario "I visit the votes page of a non-friend" do
    pending
    non_friend = create_user
    visit vote_user_page(non_friend)

    page.should_not have_content("Photos of #{non_friend.first_name}")
    page.should_not have_content("Select a photo")
  end
end
