class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @job = current_user.friends_list_job
    @friends = current_user.friends.paginate(:page => params[:page], :per_page => 20, :order => 'id ASC')
    left_row = []
    right_row = []

    @friends.each_with_index do |friend, i|
      friend_view_model = FriendViewModel.new(current_user, friend)
      if i % 2 == 0 then
        left_row << friend_view_model
      else
        right_row << friend_view_model
      end
    end

    @result = FriendsViewModel.new(:job_status => @job.status, :left_row => left_row, :right_row => right_row)
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
