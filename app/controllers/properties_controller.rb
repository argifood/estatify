class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  def index
    @properties = current_user.properties
  end

  def show
    @photos = @property.photos

    @booked = Reservation.where("property_id = ? AND user_id = ?", @property.id, current_user.id).present? if current_user

    @reviews = @property.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    @property = current_user.properties.build
  end

  def create
    @property = current_user.properties.build(property_params)

    if @property.save

      if params[:images]
        params[:images].each do |image|
          @property.photos.create(image: image)
        end
      end

      @photos = @property.photos
      redirect_to edit_property_path(@property), notice: "Saved..."
    else
      render :new
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_url, notice: 'Listing was successfully deleted.'
  end

  def edit
    if current_user.id == @property.user.id
      @photos = @property.photos
    else
      redirect_to root_path, notice: "You don't have permission"
    end
  end

  def update
    if @property.update(property_params)

      if params[:images]
        params[:images].each do |image|
          @property.photos.create(image: image)
        end
      end

      redirect_to edit_property_path(@property), notice: "Updated..."
    else
      render :edit
    end
  end

  private
    def set_property
      @property = Property.find(params[:id])
    end

    def property_params
      params.require(:property).permit(:animals, :rules, :summary, :address, :listing_name, :active, :vehicles, :drilling, :water_system, :tools, :pools_lakes, :constructions, :anti_fire, :lightning, :alarm_system, :cctv, :solar_panels, :water_supply, :power_supply, :wind_turbines, :charge_per, :price, :min_time, :space_type, :ground_type, :category, :fenced, :buildings, :flatness, :dimensions)
    end
end
