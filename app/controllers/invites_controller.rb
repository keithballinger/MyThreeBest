class InvitesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @invited = current_user.friends.find(params[:user_id])
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def all
    current_user.invite_all
    respond_to do |format|
      format.json { render :json => true }
    end
  end

  def create
    @friend = current_user.friends.find(params[:user_id])
    invite = current_user.invite(@friend, params[:invitation])
    respond_to do |format|
      format.js
    end
  end

end
