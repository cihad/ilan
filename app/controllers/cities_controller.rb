class CitiesController < ApplicationController

  def show
    self.current_city = params[:id]

    begin
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to root_path
    end
  end

end
