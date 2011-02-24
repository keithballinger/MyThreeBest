
class FriendsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @job = current_user.friends_list_job
    @friends = current_user.friends.paginate(:page => params[:page], :per_page => 10, :order => 'id ASC')

    @result = FriendsResult.new(:job_status => @job.status, :friends => @friends,
                                :friends_total_count => @friends.count)
    render :json  => @result
  end

end
