class SizesController < ApplicationController
    before_action :find_store_product
    before_action :find_size, only: [:edit, :update, :delete, :destroy]

    def index
        add_breadcrumb @store.name, store_products_path(@store)
        add_breadcrumb @product.name, store_product_path(@store, @product)
        add_breadcrumb 'Tallas', store_product_sizes_path(@store, @product)
        @product_sizes = @product.sizes.order(created_at: :desc)
    end
    
    def new
        add_breadcrumb @store.name, store_products_path(@store)
        add_breadcrumb @product.name, store_product_path(@store, @product)
        add_breadcrumb 'Nueva talla', new_store_product_size_path(@store, @product)
        @size = Size.new
    end

    def create
        @size = @product.sizes.create(size_params)
        if @size.save 
            redirect_to store_product_sizes_path(@store, @product)
        else
            render 'new'
        end
    end

    def edit
        add_breadcrumb @store.name, store_products_path(@store)
        add_breadcrumb @product.name, store_product_path(@store, @product)
        add_breadcrumb 'Modificar talla', edit_store_product_size_path(@store, @product, @size)
    end

    def update  
        if @size.update(size_params) 
            redirect_to store_product_sizes_path(@store, @product)
        else
            render 'edit'
        end        
    end

    def destroy   
        @size.destroy
        redirect_to store_product_sizes_path(@store, @product)
    end

    private
        def find_size   
            @size = Size.find(params[:id])
        end

        def find_store_product
            @store = Store.find(params[:store_id])
            @product = Product.find(params[:product_id])
        end

        def size_params
            params.require(:size).permit(:name, :ean, :price, :stock, :state)
        end
end
