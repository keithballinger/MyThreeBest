class PagesController < ApplicationController

  def index
    if user_signed_in?
      @friends = current_user.votes.includes(:voter).order("created_at desc").limit(18).map(&:voter).uniq[0..6]
      render :dashboard
    else
      render :index
    end
  end

  def dashboard ; end

  def how_it_works ; end

end
