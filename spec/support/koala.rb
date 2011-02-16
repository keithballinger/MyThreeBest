module KoalaHelpers

  # stub external connection with Facebook
  def stub_facebook_profile
    graph = mock('GraphAPI')
    graph.stubs(:get_picture).returns("http://example.org/profile_pic.png")
    Koala::Facebook::GraphAPI.stubs(:new).returns(graph)
  end
end
