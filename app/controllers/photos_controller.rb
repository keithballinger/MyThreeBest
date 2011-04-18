class PhotosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user!

  def index
    user = User.find(params[:user_id])
    photos = current_user.photos_for_friend(user).paginate(:page => params[:page], :per_page => 20)
    respond_to do |format|
      format.json{ render :json => photos }
    end
  end
end
