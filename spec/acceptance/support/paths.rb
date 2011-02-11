module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end

  def login_page
    "/auth/facebook"
  end

  def logout_page
    "/logout"
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
