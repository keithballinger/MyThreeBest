class PagesController < ApplicationController

  def index
    if user_signed_in?
      @friends = current_user.friends[0...10]
      render :dashboard
    else
      render :index
    end
  end

  def dashboard ; end

end
