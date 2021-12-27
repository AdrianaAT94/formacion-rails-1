class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, except: [:add_to_cart, :buy_cart]
  skip_before_action :set_breadcrumbs, only: [:index] 
  before_action :oculto, only: [:product]

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
    @product_sizes = @product.sizes.where("stock > 0").order(created_at: :desc)
    @category_product = @product.category_products.all
  end

  def cart
    add_breadcrumb "Carro", cart_path
    @cart = Cart.where(user_id: current_user).first     
    if @cart.present?
      @line_items = LineItem.where(cart_id: @cart.id).order(created_at: :desc)
    end
  end

  def orders
    add_breadcrumb "Pedidos", pedidos_path
  end

  def order
    add_breadcrumb "Pedido", order_path
    @order = Order.find(order_id)
    if current_user.id == @order.user_id
      if @order.present?
        @line_items = LineItem.where(order_id: @order.id).order(created_at: :desc)
      end
    else
      redirect_to cart_path
    end
  end

  def add_to_cart 
    @cart = Cart.where(user_id: current_user).first     
    unless @cart.present?
      @cart = Cart.create(user_id: current_user.id)
    end
    @line_item = LineItem.where(product_id: params[:id], size_id: params[:size_id], cart_id: @cart.id).first
    if @line_item.present?
      @line_item.update_attribute(:quantity, @line_item.quantity + 1)
    else
      @line_item = LineItem.create(product_id: params[:id], size_id: params[:size_id], cart_id: @cart.id, quantity: 1)
    end
    
    if params[:buy_now].present?
      redirect_to cart_path
    else
      redirect_back fallback_location: root_path
    end
  end 

  def modify_items
    @cart = Cart.where(user_id: current_user).first     
    if @cart.present?
      @line_item = LineItem.find(item_id)
      if @line_item.present?
        if params['operation'] == 'plus'
          size = Size.where(id: @line_item.size_id).first
          if @line_item.quantity + 1 <= size.stock
            @line_item.update_attribute(:quantity, @line_item.quantity + 1)
            redirect_to cart_path
          end
        elsif params['operation'] == 'minus'
          if @line_item.quantity > 1
            @line_item.update_attribute(:quantity, @line_item.quantity - 1)
            redirect_to cart_path
          end
        end
      end
    end
  end

  def delete_cart_item    
    @cart = Cart.where(user_id: current_user).first     
    if @cart.present?
      @line_item = LineItem.find(item_id)
      if @line_item.present?
        @line_item.destroy
        redirect_to cart_path
      end
    end
  end

  def buy_cart    
    @cart = Cart.where(user_id: current_user).first     
    if @cart.present?
      @order = Order.create(user_id: current_user.id)
      @line_items = LineItem.where(cart_id: @cart.id).order(created_at: :desc)  
      if @line_items.count > 0
        @line_items.each do |item|
          @size = Size.find(item.size_id)
          if @size.stock >= item.quantity
            item.update(cart_id: nil, order_id: @order.id)
            @size.update_attribute(:stock, @size.stock-item.quantity)
          end
        end
        @cart.destroy
        @order.update_attribute(:total, price_total)
      end
      redirect_to @order
    end    
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

      def order_id
        params[:id]
      end

      def category_id
        params[:category_id]
      end

      def item_id
          params[:format]
      end

      def price_total
          params[:price_total]
      end
end
