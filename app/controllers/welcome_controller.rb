class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :set_breadcrumbs, only: [:index] 
  before_action :oculto, only: [:product_store, :product]
  
  # lo que esta comentado es para todas las tienda, solo trabajar con tienda 1
  
  def index
    #@products = Product.order(created_at: :desc)    
    @store = Store.find(1)
    @products = @store.products.order(created_at: :desc)
    @sliders = Slider.order(created_at: :desc)
  end

  # def stores
  #   add_breadcrumb "Tiendas", tiendas_path
  #   @stores = Store.all
  # end

  def products
    add_breadcrumb "Productos", productos_path
    #@products = Product.order(created_at: :desc)    
    @store = Store.find(1)
    @products = @store.products.search_name(params[:name]).order(created_at: :desc)
    @categories = Category.all
  end

  def product
    add_breadcrumb "Productos", productos_path
    @product = Product.find(product_id)
    add_breadcrumb @product.name, producto_path
    @product_sizes = @product.sizes.order(created_at: :desc)
    @category_product = @product.category_products.all
  end

  # def products_store    
  #   add_breadcrumb "Tiendas", :tiendas_path
  #   @store = Store.find(store_id)
  #   @store_name = @store.name + ' : Productos'
  #   add_breadcrumb @store_name, tienda_path(@store)
  #   @store_products = @store.products.order(created_at: :desc)
  # end

  # def product_store    
  #   add_breadcrumb "Tiendas", :tiendas_path
  #   @store = Store.find(store_id)
  #   @store_name = @store.name + ' : Productos'
  #   add_breadcrumb @store_name, tienda_path(@store)
  #   @product = Product.find(product_id)
  #   add_breadcrumb @product.name, producto_tienda_path(@store, @product)
  #   @product_sizes = @product.sizes.order(created_at: :desc)
  #   @category_product = @product.category_products.all
  # end

  private
      def oculto
          redirect_to tiendas_path(@store) if @product = Product.find(params[:product_id]).state == 'oculto' 
      end

      def product_id
        params[:product_id]
      end

      def store_id
        params[:store_id]
      end
end
