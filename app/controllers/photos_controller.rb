class PhotosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user!

  def index
    user = User.find(params[:user_id])
    photos = current_user.photos_for_friend(user, params[:page])
    respond_to do |format|
      format.json{ render :json => photos }
    end
  end
end
