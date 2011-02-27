class FriendsController < ApplicationController
  before_filter :authenticate_user!

  def index
    #
    # get the job status
    #
    @job = current_user.friends_list_job

    #
    # get 20 friends
    #
    @friends = current_user.friends.paginate(:page => params[:page], :per_page => 20, :order => 'id ASC')

    #
    # initialize the left and right rows in the view model
    #
    @left_row = Array.new
    @right_row = Array.new

    #
    # loop through the friends
    # even friends go in the left column
    # odd friends go in the right column
    #
    @friends.each_with_index do |friend, i|

      #
      # create a friend_view_model from the friend_model
      #
      @friend_view_model = FriendViewModel.new(
          :name => friend.first_name + friend.last_name,
          :profile_image_url => friend.profile_picture,
          :has_voted => false
        )

      #
      # decide which column they go into
      #
      if i % 2 == 0 then
        @left_row << @friend_view_model
      else
        @right_row << @friend_view_model
      end

    end

    #
    # create the view model for the friends display
    #
    @result = FriendsViewModel.new(
       :job_status => @job.status,
       :left_row => @left_row,
       :right_row => @right_row)

    render :json  => @result
  end

end
