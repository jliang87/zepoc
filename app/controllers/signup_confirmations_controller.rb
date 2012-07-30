class SignupConfirmationsController < ApplicationController

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
