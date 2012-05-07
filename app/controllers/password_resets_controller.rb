class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	user.send_password_reset if user
    redirect_to root_path
  	flash[:success] = 'Email sent for password resetting!'
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end
end
