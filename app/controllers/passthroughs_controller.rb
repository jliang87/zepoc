class PassthroughsController < ApplicationController
  def index
    if signed_in?
      redirect_to current_user
    else
      render 'static_pages/home'
    end
  end
end
