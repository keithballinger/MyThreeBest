class SessionsController < ApplicationController

  def create
    render :text => request.env["omniauth.auth"].to_yaml.to_s.gsub("\n","<br/>")
  end
end
