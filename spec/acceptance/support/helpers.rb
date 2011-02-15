module HelperMethods
  # Put helper methods you need to be available in all tests here.

  def create_user
    #User.create_with_omniauth(OmniAuth.config.mock_auth[:facebook])
    user = Factory(:user)
    stub_friends
    return user
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
