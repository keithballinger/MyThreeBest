module AcceptanceHelperMethods
  # Put helper methods you need to be available in all tests here.

  def create_user
    user = User.create_with_omniauth(OmniAuth.config.mock_auth[:facebook].merge("uid" => rand(1000000000)))
  end
end

RSpec.configuration.include AcceptanceHelperMethods, :type => :acceptance
