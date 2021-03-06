class NodesController < ApplicationController

  layout :set_layout

  def show
    @node = Node.find(params[:id])
  end

  def new
    @node = Node.new(city_id: current_city.id, email: cookies[:email])
  end

  def create
    @node = Node.new(node_params)

    @node.valid? # Perform validations

    # If node email is valid format
    cookies[:email] = @node.email unless @node.errors.keys.include? :email

    respond_to do |format|
      if @node.save
        format.html { redirect_to @node, notice: I18n.t('nodes.flash.created') }
        format.json { render action: 'show', status: :created, location: @node }
      else
        format.html { render action: 'new' }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def node_params
      params.require(:node).permit( :title, :email, :description, :contact,
                                    :city_id, :category_id, imgs: [])
    end

    def set_layout
      case params[:action]
        when "new" then "simple"
        else            "application"
      end
    end
end
