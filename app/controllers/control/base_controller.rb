module Control
  class BaseController < ApplicationController
    before_action :set_default_breadcrumb
    layout "control"
    http_basic_authenticate_with  name:     ENV['CONTROL_USERNAME'],
                                  password: ENV["CONTROL_PASSWORD"]

    def index
    end

    private

      def set_default_breadcrumb
        unless params[:controller] == "control/base" and params[:action] == "index"
          breadcrumbs.item I18n.t('control'), control_path
        end
      end
  end
end
