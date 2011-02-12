require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Users Logout", %q{
  In order to finish using the page
  As a logged user
  I want to logout from the page
} do

  scenario "I logout from the page" do
    graph = mock('GraphAPI')
    users = [{"name" => "John Doe", "id" => "1"}, {"name" => "Joe Dohn", "id" => "2"}]
    graph.stubs(:get_connections).returns(users)
    Koala::Facebook::GraphAPI.stubs(:new).returns(graph)

    visit login_page
    visit logout_page
    page.should have_content('Login with Facebook')
  end
end
