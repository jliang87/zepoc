module SessionsHelper
  
  def sign_in(user)
    if params[:remember_me]
      cookies.permanent[:remember_token] = user.remember_token
    else
      session[:remember_token] = user.remember_token
    end
    current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    current_user = nil
    unless cookies[:remember_token].nil?
      cookies.delete(:remember_token)
    else
      session[:remember_token] = nil
    end
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  private
    def user_from_remember_token
      unless cookies[:remember_token].nil?
        remember_token = cookies[:remember_token]
      else
        remember_token = session[:remember_token]
      end
      User.find_by_remember_token(remember_token) unless remember_token.nil?
    end
  
end