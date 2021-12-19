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

    def new_images
    end
    
    def create_images      
        if params[:images].present?
            params[:images].each do |image|
                @product.images.attach(image)
            end
        end
        redirect_to product_images_path(@store, @product) 
    end

    def show_images     
    end

    def delete_image     
        @image = ActiveStorage::Attachment.find(params[:image_id])
        @image.purge_later
        redirect_to product_images_path(@store, @product) 
    end

    def edit_image
        @image = ActiveStorage::Attachment.find(params[:image_id])
    end

    def update_image      
        @image = ActiveStorage::Attachment.find(params[:image_id])
        @image.purge_later
        @product.images.attach(params[:image])
        redirect_to product_images_path(@store, @product) 
    end

    private
        def find_store
            @store = Store.find(params[:store_id])
        end

        def find_product   
            @product = Product.find(params[:id])
        end

        def product_params
            params.require(:product).permit(:name, :description, :reference, :state)
        end
end