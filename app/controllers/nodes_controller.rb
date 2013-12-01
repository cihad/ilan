class NodesController < ApplicationController

  def show
    @node = Node.find(params[:id])
  end

  def new
    @node = Node.new
  end

  def create
    @node = Node.new(node_params)

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
      params.require(:node).permit(:title, :email, :description, :contact, :city_id)
    end
end
