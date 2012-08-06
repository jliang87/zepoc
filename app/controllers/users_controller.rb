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
      QC.enqueue "User.send_signup_confirmation", @user.email
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
    if @user.update_attributes(params[:user])
      #something
    else
      @user.errors.full_messages.each do |msg| 
        flash.now[:error] = msg 
      end
      render 'edit'
    end
  end
 
end
