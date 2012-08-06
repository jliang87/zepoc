class PasswordResetsController < ApplicationController

  def new
  end

  def create
    QC.enqueue "User.send_password_reset", params[:email]
    redirect_to root_path
  	flash[:success] = 'Email sent for password reset!'
  end

  def edit
   	@user = User.find_by_password_reset_token!(params[:id])
   	if @user.need_password_reset == false 
   		redirect_to root_path
  		flash[:error] = 'Oops, this request is no longer valid.'
  	end
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.need_password_reset == false
  		redirect_to root_path
  	  	flash[:error] = "This password reset request was completed!"
  	elsif @user.password_sent_at < 2.hours.ago
  		redirect_to new_password_reset_path
  		flash[:error] = "This password reset request has expired. Please try again."
  	elsif @user.update_attributes(params[:user])
  		@user.need_password_reset = false
  		@user.update_attributes!(params[:need_password_reset])
  	  redirect_to root_path
  	  flash[:success] = "Password reset has been done!"
  	else
  	  @user.errors.full_messages.each do |msg| 
    	 	flash.now[:error] = msg 
      end
    	render :edit
  	end
  end
end
