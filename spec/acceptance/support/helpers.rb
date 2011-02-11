module HelperMethods
  # Put helper methods you need to be available in all tests here.

  def create_user
    User.create_with_omniauth(OmniAuth.config.mock_auth[:facebook])
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
