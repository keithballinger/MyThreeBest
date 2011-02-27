class VotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user!

  def new
    @user = User.find(params[:user_id])
    @photos = @user.photos
    respond_to do |format|
      format.html
    end
  end


  private
  def authorize_user!
    redirect_to root_path unless current_user.friend?(User.find(params[:user_id]))
  end

end
