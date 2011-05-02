class PagesController < ApplicationController

  def index
    if user_signed_in?
      @job = current_user.friends_list_job
      @friends = current_user.votes.includes(:voter).order("created_at desc").limit(18).map(&:voter).uniq[0..6]
      render :dashboard
    else
      render :index
    end
  end

  def dashboard ; end

end
