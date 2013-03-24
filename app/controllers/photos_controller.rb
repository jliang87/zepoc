class PhotosController < ApplicationController

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.create(params[:photo])
    @user = User.find_by_name params[:user_id]
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
      #flash[:notice] = "Successfully updated."
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    else
      @photo.errors.full_messages.each do |msg|
        flash[:notice] = msg
      end
      #respond_to do |format|
      #  format.html { redirect_to @user }
      #  format.js
      #end
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @user = User.find_by_name params[:user_id]
    @photo.destroy
    #flash[:notice] = "Successfully deleted."
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def download
    @photo = Photo.find(params[:id])

    data = open(@photo.photo.url)
    send_data  data.read,
               :filename => @photo.photo.original_filename,
               :disposition => 'attachment'
    end

end
