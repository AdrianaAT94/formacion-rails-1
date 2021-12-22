class CategoriesController < ApplicationController
  before_action :find_category, except: [:index, :new, :create]
  add_breadcrumb "Categorías", :categories_path

  def index
    @categories = Category.all
  end

  def show
  end

  def new        
    add_breadcrumb "Nueva categoría", new_category_path
    @category = Category.new
  end

  def edit
    @category_name = 'Modificar ' + @category.name
    add_breadcrumb @category_name, edit_category_path(@category)
  end

  def create
    @category = Category.new(category_params)
    if @category.save 
      redirect_to categories_path
    else
      render 'new'
    end
end

  def update
    if @category.update(category_params) 
      redirect_to categories_path
    else
        render 'edit'
    end        
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private
    def find_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
