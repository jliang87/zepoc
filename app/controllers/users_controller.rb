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
    @user = User.find_by_signup_confirmation_token!(params[:id])
    if @user.need_signup_confirmation == true
      @user.need_signup_confirmation = false
      @user.save! validate: false
      unless signed_in?
        sign_in @user
      end
      redirect_to @user
      flash[:info] = 'Thanks for confirming your email!'
    else
      redirect_to root_path
      flash[:error] = 'Oops, this request is no longer valid.'
    end
  end
 
end
