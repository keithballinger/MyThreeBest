class FriendsResult
  attr_accessor :job_status, :friends, :friends_page_count, :friends_total_count
end

class FriendsController < ApplicationController
  before_filter :authenticate_user!
  
  def list
    @job = current_user.friends_list_job
    @friends = current_user.friends.paginate(:page => params[:page], :per_page => 10, :order => 'id ASC')
    
    @result = FriendsResult.new
    @result.job_status = @job.status
    @result.friends = @friends
    @result.friends_total_count = @friends.count
    
    render :json  => @result
  end

end
