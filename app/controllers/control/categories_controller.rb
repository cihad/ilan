module Control
  class CategoriesController < BaseController
    before_action :set_category, only: [:edit, :update, :destroy]
    before_action :set_breadcrumb, except: :index

    def index
      @categories = Category.all
    end

    def new
      @category = Category.new
    end

    def edit
    end

    def create
      @category = Category.new(category_params)

      if @category.save
        redirect_to control_categories_path, notice: I18n.t('categories.flash.created')
      else
        flash[:alert] = I18n.t('categories.flash.not_created')
        render action: 'new'
      end
    end

    def update
      if @category.update(category_params)
        redirect_to control_categories_path, notice: I18n.t('categories.flash.updated')
      else
        flash[:alert] = I18n.t('categories.flash.not_updated')
        render action: 'edit'
      end
    end

    def destroy
      @category.destroy
      redirect_to control_categories_url
    end

    private
      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name, :icon)
      end

      def set_breadcrumb
        breadcrumbs.item t('categories.index.categories'), control_categories_path
      end
  end
end