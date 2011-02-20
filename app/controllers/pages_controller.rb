class PagesController < ApplicationController

  def index
    if user_signed_in?
      @job = current_user.friends_list_job
      render :dashboard
    else
      render :index
    end
  end

  def dashboard ; end

end
