class UsersController < ApplicationController
  def show
    @user = User.find_by_name params[:name]
  end 
  
  def new
    @user = User.new
  end
   
  def create
     @user = User.new(params[:user])
     if @user.save
       sign_in @user
       name = @user.name
       flash[:success] = "Welcome to zepoc! Have a good one :)"
       redirect_to "/#{name}"
     else
       render 'new'
     end
  end
 
end
