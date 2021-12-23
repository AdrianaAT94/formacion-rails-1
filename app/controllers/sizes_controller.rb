class SizesController < ApplicationController
    before_action :find_product
    before_action :find_size, only: [:edit, :update, :delete, :destroy]

    def index
        add_breadcrumb @product.name, product_path(@product)
        add_breadcrumb 'Tallas', product_sizes_path(@product)
        @product_sizes = @product.sizes.order(created_at: :desc)
    end
    
    def new
        add_breadcrumb @product.name, product_path(@product)
        add_breadcrumb 'Nueva talla', new_product_size_path(@product)
        @size = Size.new
    end

    def create
        @size = @product.sizes.create(size_params)
        if @size.save 
            redirect_to product_sizes_path(@product)
        else
            render 'new'
        end
    end

    def edit
        add_breadcrumb @product.name, product_path(@product)
        add_breadcrumb 'Modificar talla', edit_product_size_path(@product, @size)
    end

    def update  
        if @size.update(size_params) 
            redirect_to product_sizes_path(@product)
        else
            render 'edit'
        end        
    end

    def destroy   
        @size.destroy
        redirect_to product_sizes_path(@product)
    end

    private
        def find_size   
            @size = Size.find(params[:id])
        end

        def find_product
            @product = Product.find(params[:product_id])
        end

        def size_params
            params.require(:size).permit(:name, :ean, :price, :stock, :state)
        end
end
