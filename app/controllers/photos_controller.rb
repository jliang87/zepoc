class PhotosController < ApplicationController

  def new
    @photo = Photo.new
  end

  def edit
    @photo = Photo.find(params[:id])
    @user = User.find_by_name params[:user_id]
  end

  def show
    @photo = Photo.find params[:id]
  end

  def update
    @photo = Photo.find(params[:id])
    @user = User.find_by_name params[:user_id]
    if @photo.update_attributes(params[:photo])
      flash.now[:notice] = "Successfully updated."
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    else
      @photo.errors.full_messages.each do |msg|
        flash.now[:notice] = msg
      end
      render 'edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @user = User.find_by_name params[:user_id]
    @photo.destroy
    flash[:notice] = "Successfully deleted."
    redirect_to @user
  end

end