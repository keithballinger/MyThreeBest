module AcceptanceHelperMethods
  # Put helper methods you need to be available in all tests here.

  def create_user
    user = Factory.create(:registered_user)
  end

end

RSpec.configuration.include AcceptanceHelperMethods, :type => :request
