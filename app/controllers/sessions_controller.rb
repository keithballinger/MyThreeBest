class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    @user = User.find_or_create_with_omniauth(auth)
    sign_in_and_redirect(@user)
  end
end
