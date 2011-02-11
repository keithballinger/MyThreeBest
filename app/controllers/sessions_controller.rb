class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    @user = User.find_by_facebook_uid(auth["uid"]) || User.create_with_omniauth(auth)
    sign_in_and_redirect(@user)
  end
end
