class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :authenticate if Rails.env.staging?

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
        username == "m3b" && password == "m3b-staging"
    end
    warden.custom_failure! if performed?
  end

  protected

  def authorize_user!
    Rails.logger.info "*"*50
    Rails.logger.info request.env['HTTP_USER_AGENT']
    Rails.logger.info "*"*50
    user = User.find(params[:user_id])
    redirect_to root_path unless user.token == params[:token]
  rescue
    redirect_to root_path
  end
end
