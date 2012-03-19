class UsersController < ApplicationController
  def show
    email = User.param_to_email params[:id]
    @user = User.find_by_email email
  end 
  
  def new
    @user = User.new
  end
   
  def create
     @user = User.new(params[:user])
     if @user.save
       sign_in @user
       flash[:success] = "Welcome to zepoc! Have a good one :)"
       redirect_to @user
     else
       render 'new'
     end
  end
 
end
