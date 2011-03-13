require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Show User Photos Feature", %q{
  In order to vote in friends photos
  As an User
  I want to see the photos of my friends
} do

  background do
    stub_facebook_profile
    visit login_page
    @voter = User.first
  end

  scenario "I visit the votes page of a friend" do
    friend = Factory.create(:registered_user)
    @voter.friend(friend)
    photos = create_photos_with_permissions(friend, 5, @voter)
    visit vote_user_page(friend)

    page.should have_content("Photos of #{friend.first_name}")
    page.should have_content("Select a photo")
  end

  scenario "I visit the votes page of a non-friend" do
    non_friend = Factory.create(:registered_user)
    other_non_friend = Factory.create(:registered_user)
    photos = create_photos_with_permissions(non_friend, 5, other_non_friend)
    visit vote_user_page(non_friend)

    page.should_not have_content(non_friend.first_name)
    page.should_not have_content(photos.first.preview_url)
  end

end
