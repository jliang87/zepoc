class UsersController < ApplicationController

  before_filter :user_signed_in, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]

  def show
    @user = User.find_by_name params[:id]
    if signed_in?
      if @user.name == current_user.name
        @photo = Photo.new
      end
    end
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
      flash[:success] = "Welcome to zepoc!"
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

    if  params[:user][:crop_x].blank? &&
        params[:user][:crop_y].blank? &&
        params[:user][:crop_w].blank? &&
        params[:user][:crop_h].blank? &&
        @user.authenticate(params[:user][:password]) &&
        @user.update_attributes(params[:user])  # or possibly cant use save in general
          #if params[:user][:destroy_avatar]
          #  @user.avatar.destroy
          #end   # wont save avatar's attributes
          redirect_to @user
    #    @user.update_attributes(params[:user]) #***cant use save for attr_accessor's for they aren't in db***
    elsif !params[:user][:crop_x].blank? &&
          !params[:user][:crop_y].blank? &&
          !params[:user][:crop_w].blank? &&
          !params[:user][:crop_h].blank? &&
          @user.update_attribute(:crop_x, params[:user][:crop_x]) &&
          @user.update_attribute(:crop_y,  params[:user][:crop_y]) &&
          @user.update_attribute(:crop_w,  params[:user][:crop_w]) &&
          @user.update_attribute(:crop_h,  params[:user][:crop_h])
            @user.reprocess_avatar
            redirect_to @user
    else
      unless @user.authenticate(params[:user][:password])
        @user.errors.full_messages.push("Oops, wrong password. Please try again.").each do |msg|
          flash.now[:error] = msg
        end
      else
        @user.errors.full_messages.each do |msg|
          flash.now[:error] = msg
        end
      end
      render 'edit'
    end
  end

  private
    def user_signed_in
      unless signed_in?
        redirect_to signin_path
        flash[:error] = "Please sign in first!"
      end
    end

    def correct_user
      @user = User.find_by_name params[:id]
      unless current_user? @user
        redirect_to current_user
        flash[:error] = "Oops, wrong way"
      end
    end
 
end
