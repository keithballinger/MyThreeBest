class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => :show

  def index #TODO: I think we don't need this anymore
    @friends = current_user.votes.order("created_at desc").limit(18).map(&:voter).uniq[0..6]
    respond_to do |format|
      format.html { render :show }
    end
  end

  def show
    @user = User.find_by_public_page_url(params[:public_page_url])
    if @user.public_page?
      respond_to do |format|
        format.html { render :show }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    end
  end

  def update
    current_user.update_attribute(:public_page, params[:user][:public_page])
    respond_to do |format|
      format.js
    end
  end

end
