class UsersController < ApplicationController
  def show
    @user = User.find_by_name params[:id]
  end 
  
  def new
    @user = User.new
  end
   
  def create
    @user = User.new(params[:user])
    if @user.save
      User.send_signup_confirmation @user.email
      sign_in @user
      redirect_to @user
      flash[:success] = "Welcome to zepoc! Have a good one :)"
    else
      @user.errors.full_messages.each do |msg| 
        flash.now[:error] = msg 
      end
      render 'new'
     end
  end

  def edit
    @user = User.find_by_name params[:id]
  end

  def update
    @user = User.find_by_name params[:id]
    #if @user.save! validate: false  ***cant use for attr_accessor's for they aren't in db***
    if @user.update_attribute(:crop_x, params[:user][:crop_x]) &&
       @user.update_attribute(:crop_y,  params[:user][:crop_y]) &&
       @user.update_attribute(:crop_w,  params[:user][:crop_w]) &&
       @user.update_attribute(:crop_h,  params[:user][:crop_h])
      render 'show'
      #something
    else
      @user.errors.full_messages.each do |msg|
        flash.now[:error] = msg
      end
      render 'edit'
    end
  end
 
end
