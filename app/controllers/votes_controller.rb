class VotesController < ApplicationController
  before_filter :authorize_user!, :only => :new
  before_filter :authenticate_user!, :except => :new

  def index
    @photos = current_user.voted_photos.page(params[:page]).per(1).includes(:voters)
    respond_to do |format|
      format.html
    end
  end

  def show
    @voters_with_votes = current_user.voters_with_votes(params[:page])
    respond_to do |format|
      format.html
    end
  end

  def new
    @user = User.find(params[:user_id])
    if facebook_request?
      render :facebook
    else
      authenticate_user! unless facebook_request?
      voted_photos = current_user.votes_for(@user)
      @first_voted  = voted_photos[0] rescue nil
      @second_voted = voted_photos[1] rescue nil
      @third_voted  = voted_photos[2] rescue nil
      @photos = current_user.photos_for_friend(@user, params[:page])
      respond_to do |format|
        format.html
      end
    end
  end

  def create
    photos_ids = params[:vote].delete_if{|id| id == ""}
    @photos = photos_ids.map{|id| Photo.find(id)}
    if current_user.vote(@photos)
      respond_to do |format|
        format.js{ render :json => true }
      end
    end
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    if current_user.unvote(@photo)
      respond_to do |format|
        format.js{ render :json => true }
      end
    end
  end

  def facebook_request?
    Rails.logger.info "*"*50
    Rails.logger.info request.env['HTTP_USER_AGENT']
    request.env['HTTP_USER_AGENT'] == "facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)"
  end
end
