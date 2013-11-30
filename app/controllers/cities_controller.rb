class CitiesController < ApplicationController
  before_action :set_city, only: [:edit, :update, :destroy]

  def index
    @cities = City.all
  end

  def new
    @city = City.new
  end

  def edit
  end

  def create
    @city = City.new(city_params)

    if @city.save
      redirect_to cities_path, notice: I18n.t('cities.flash.created')
    else
      render action: 'new'
    end
  end

  def update
      if @city.update(city_params)
        redirect_to cities_path, notice: I18n.t('cities.flash.updated')
      else
        render action: 'edit'
      end
  end

  def destroy
    @city.destroy
      redirect_to cities_url
  end

  private
    def set_city
      @city = City.find(params[:id])
    end

    def city_params
      params.require(:city).permit(:name)
    end

end
