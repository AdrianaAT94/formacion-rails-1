class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :oculto, only: [:product_store, :product]

  def index
    @products = Product.order(created_at: :desc)
    @sliders = Slider.order(created_at: :desc)
  end

  def stores
    @stores = Store.all
  end

  def products
    @products = Product.order(created_at: :desc)
  end

  def product
    @product = Product.find(params[:product_id])
    @product_sizes = @product.sizes.order(created_at: :desc)
  end

  def products_store    
    @store = Store.find(params[:store_id])
    @store_products = @store.products.order(created_at: :desc)
  end

  def product_store    
    @store = Store.find(params[:store_id])
    @product = Product.find(params[:product_id])
    @product_sizes = @product.sizes.order(created_at: :desc)
  end

  private
      def oculto
          redirect_to tiendas_path(@store) if @product = Product.find(params[:product_id]).state == 'oculto' 
      end

end
