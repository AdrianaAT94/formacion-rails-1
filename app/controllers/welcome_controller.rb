class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  #before_action :oculto

  def index
    @products = Product.all
  end

  def products_store    
    @store = Store.find(params[:store_id])
  end

  def product_store    
    @store = Store.find(params[:store_id])
    @product = Product.find(params[:product_id])
  end

  private
      def oculto
          redirect_to tiendas_path(@store) if @product = Product.find(params[:product_id]).state == 'oculto' 
      end

end
