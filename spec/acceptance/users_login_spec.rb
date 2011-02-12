require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Users Login", %q{
  In order to start using the page
  As a potential user
  I want to login using my Facebook account
} do

  scenario "I login in the page" do
    graph = mock('GraphAPI')
    users = [{"name" => "John Doe", "id" => "1"}, {"name" => "Joe Dohn", "id" => "2"}]
    graph.stubs(:get_connections).returns(users)
    Koala::Facebook::GraphAPI.stubs(:new).returns(graph)

    visit login_page
    page.should have_content('Welcome John')
    page.should have_content('Logout')
  end
end
