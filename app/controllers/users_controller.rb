class UsersController < ApplicationController

  def show
    names = params[:full_name].split("_")
    @user = User.where('lower(first_name) = :first_name and lower(last_name) = :last_name', 
                       :first_name => names.first.downcase, :last_name => names.last.downcase).first
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
  end

end
