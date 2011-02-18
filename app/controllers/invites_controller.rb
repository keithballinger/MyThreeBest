class InvitesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @job = current_user.user_jobs.where(:job_type => "friends_list").first
    @friends = current_user.friends.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.js
    end
  end
end
