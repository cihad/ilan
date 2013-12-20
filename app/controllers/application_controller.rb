require './lib/breadcrumbs'

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
end
