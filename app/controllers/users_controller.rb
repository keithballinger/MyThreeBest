class UsersController < ApplicationController

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
