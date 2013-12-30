require './lib/breadcrumbs'
require 'default_city_policy'

class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_home_breadcrumb

  private
    helper_method :breadcrumbs
    def breadcrumbs
      @breadcrumbs ||= Breadcrumbs.new
    end

    def set_home_breadcrumb
      unless params[:controller] == "home_page" and params[:action] == "index"
        breadcrumbs.item I18n.t('home'), root_path
      end
    end

    helper_method :current_city
    def current_city
      @_current_city ||=  session[:current_city_id] && 
                            City.find_by(id: session[:current_city_id]) ||
                          DefaultCityPolicy.default_city
    end

    def current_city= id
      session[:current_city_id] = id
      @_current_city = City.find_by(id: id)
    end
end
