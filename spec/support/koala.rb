module KoalaHelpers

  # stub external connection with Facebook
  def stub_friends(n=10)
    graph = mock('GraphAPI')
    users = []
    (0...n).each do
      users << {"name" => Faker::Name.name, "id" => rand(100000) + 10000000}
    end
    graph.stubs(:get_connections).returns(users)
    Koala::Facebook::GraphAPI.stubs(:new).returns(graph)
  end
end
