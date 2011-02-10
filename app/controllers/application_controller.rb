class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_for_staging if Rails.env.staging?

  def authenticate_for_staging
    authenticate_or_request_with_http_basic do |username, password|
        username == "m3b" && password == "m3b-staging"
    end
  end
end
