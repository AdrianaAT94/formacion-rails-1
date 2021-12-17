class ProductsController < ApplicationController
    before_action :find_store
    before_action :find_product, except: [:index, :new, :create]

    def index
    end

    def new
        @product = Product.new
    end

    def create
        @product = @store.products.create(product_params)
        if @product.save
            redirect_to store_path(@store)
        else
            render 'new'
        end
    end

    def show
    end

    def edit
    end

    def update  
        if @product.update(product_params) 
            redirect_to store_product_path(@store, @product)
        else
            render 'edit'
        end        
    end

    def destroy   
        @product.destroy
        redirect_to store_path(@store)
    end

    def delete_image 
    
    end

    private
        def find_store
            @store = Store.find(params[:store_id])
        end

        def find_product   
            @product = Product.find(params[:id])
        end

        def product_params
            params.require(:product).permit(:name, :description, :image, :reference, :state)
        end
end
