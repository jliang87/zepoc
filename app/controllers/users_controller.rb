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
       sign_in @user
       redirect_to @user
       flash[:success] = "Welcome to zepoc! Have a good one :)"
     else
      @user.errors.full_messages.each do |msg| 
        if msg.include? "Password doesn't match confirmation"
          flash.now[:error] = msg 
        end
        if flash.empty? && msg.include?("has already been taken")
          flash.now[:error] = msg 
        elsif !flash.empty? && msg.include?("has already been taken")
          flash.now[:error] << " and " + msg.downcase!
        end
      end
       render 'new'
     end
  end
 
end
