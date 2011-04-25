class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @job = current_user.friends_list_job
    @friends = current_user.friends.paginate(:page => params[:page], :per_page => 20, :order => 'id ASC')
    rows = []

    @friends.each_slice(2) do |friends|
      friend_view_model = FriendViewModel.new(current_user, friends[0], friends[1])
      rows << friend_view_model
    end

    @result = FriendsViewModel.new(:job_status => @job.status, :rows => rows,
                                   :count => @friends.count, :page => params[:page])
    render :json  => @result
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
