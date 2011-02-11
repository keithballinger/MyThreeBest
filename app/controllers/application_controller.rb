class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate if Rails.env.staging?

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
        username == "m3b" && password == "m3b-staging"
    end
    warden.custom_failure! if performed?
  end
end
