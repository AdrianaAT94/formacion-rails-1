class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, except: [:add_to_cart, :buy_cart]
  skip_before_action :set_breadcrumbs, only: [:index] 
  before_action :oculto, only: [:product]
  before_action :no_order, only: [:order]  
  
  def index
    @products = Product.order(created_at: :desc)
    @sliders = Slider.order(created_at: :desc)
  end

  def products
    add_breadcrumb "Productos", productos_path
    @products = Product.search_category_id(category_id).order(created_at: :desc)
    @categories = Category.all
  end

  def product
    add_breadcrumb "Productos", productos_path
    @product = Product.find(product_id)
    add_breadcrumb @product.name, producto_path
    @product_sizes = @product.sizes.order(created_at: :desc)
    @category_product = @product.category_products.all
  end

  def cart
    add_breadcrumb "Carro", cart_path
  end

  def order
    add_breadcrumb "Pedido", order_path
  end

  def add_to_cart 
    @cart = Cart.where(user_id: current_user)      
    if @cart.present?
      render plain: params
    else
      @cart = Cart.create(user_id: current_user.id)
      render plain: '2'
    end
    
    # if params[:buy_now].present?
    #   redirect_to cart_path
    # else
    #   redirect_back fallback_location: root_path
    # end
  end 

    def buy_cart 
      redirect_to order_path
    end 

  private
      def oculto
          redirect_to products_path if @product = Product.find(params[:id]).state == 'oculto' 
      end

      def no_order
          redirect_to cart_path unless params[:order_id].present?
      end

      def product_id
        params[:id]
      end

      def category_id
        params[:category_id]
      end

      def cart_item_params
        params[:category_id]
      end
end
