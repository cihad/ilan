module Control
  class BaseController < ApplicationController
    before_action :set_default_breadcrumb
    layout "control"

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
