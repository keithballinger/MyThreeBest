class VotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user!

  def new
    @user = User.find(params[:user_id])
    votes = @user.votes.where(:voter_id => current_user.id)
    @first_voted  = votes[0].photo rescue nil
    @second_voted = votes[1].photo rescue nil
    @third_voted  = votes[2].photo rescue nil
    @photos = @user.photos
    respond_to do |format|
      format.html
    end
  end

  def create
    @photo = Photo.find(params[:photo_id])
    if current_user.vote(@photo)
      respond_to do |format|
        format.js{ render :json => true }
      end
    else
      respond_to do |format|
        format.js{ render :json => false }
      end
    end
  end


  private
  def authorize_user!
    redirect_to root_path unless current_user.friend?(User.find(params[:user_id]))
  end

end
