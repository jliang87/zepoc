class UsersController < ApplicationController
  def show
    @user = User.find(params[:email])
  end 
  
  def new
    @user = User.new
  end
   
  def create
     @user = User.new(params[:user])
     if @user.save
       flash[:success] = "Welcome to zepoc!"
       redirect_to @user
     else
       render 'new'
     end
  end
 
end
