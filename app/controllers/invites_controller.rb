class InvitesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @job = current_user.friends_list_job
    @friends = current_user.friends.paginate(:page => params[:page], :per_page => 10, :order => 'id ASC')
    respond_to do |format|
      format.js
    end
  end

  def all
    current_user.invite_all
    render :json => true
  end

  def create
    @friend = current_user.friends.find(params[:user_id])
    invite = current_user.invite(@friend)

    respond_to do |format|
      format.js
    end
  end

end
