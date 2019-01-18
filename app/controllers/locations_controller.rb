class LocationsController < ApplicationController
  load_and_authorize_resource

  def index
    @locations = @locations.newest.paginate page: params[:page],
      per_page: Settings.locations.paginate.per_page
  end

  def show; end

  def new
    @image = @location.images.build
  end

  def create
    @location = Location.new location_params
    if @location.save
      params[:images]["url"].each do |a|
        @image = @location.images.create! url: a
      end

      flash[:success] = t ".flash.create_location_successful"
      redirect_to @location
    else
      flash.now[:danger] = t ".flash.create_location_failed"
      @image = @location.images.build
      render :new
    end
  end

  def edit; end

  def update
    if @location.update_attributes location_params
      flash[:success] = t ".flash.update_location_successful"
      redirect_to edit_location_path
    else
      flash.now[:danger] = t ".flash.update_location_failed"
      render :edit
    end
  end

  def destroy
    if @location.destroy
      flash[:success] = t ".flash.delete_location_successful"
    else
      flash[:danger] = t ".flash.delete_location_failed"
    end
    redirect_to locations_path
  end

  private

  def location_params
    params.require(:location).permit :name, :description,
      images_attributes: [:id, :url, :_destroy]
  end
end
