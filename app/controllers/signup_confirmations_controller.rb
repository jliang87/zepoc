class SignupConfirmationsController < ApplicationController

  def edit
    @user = User.find_by_signup_confirmation_token!(params[:id])
    if @user.need_signup_confirmation?
      if !signed_in? || (signed_in? && current_user.name == @user.name)
        @user.need_signup_confirmation = false
        @user.save! validate: false
        unless signed_in? 
          sign_in @user
        end
        redirect_to @user
        flash[:info] = 'Thanks for confirming your email!'
      else
        redirect_to root_path
        flash[:error] = "Oops, the current account doesn't match the originator of this request."
      end
    else
      redirect_to root_path
      flash[:error] = 'Oops, this request is no longer valid.'
    end
  end

end
