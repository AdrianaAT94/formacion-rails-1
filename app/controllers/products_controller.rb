class ProductsController < ApplicationController
    before_action :find_store
    before_action :find_product, except: [:index, :new, :create]   
    add_breadcrumb "Tiendas registradas", :stores_path 

    def index
        @store_name = @store.name + ' : Productos'
        add_breadcrumb @store_name, store_products_path(@store)
        @store_products = @store.products.order(created_at: :desc)
    end

    def new
        add_breadcrumb @store.name, store_products_path(@store)
        add_breadcrumb 'Nuevo producto', new_store_product_path(@store)
        @product = Product.new
    end

    def create
        @product = @store.products.create(product_params)
        if @product.save
            if category_params.present?
                category_params.each do |category|
                    @category_product = @product.category_products.create(category_id: category)
                end
            end
            redirect_to store_path(@store)
        else
            render 'new'
        end
    end

    def show
        add_breadcrumb @store.name, store_products_path(@store)
        add_breadcrumb @product.name, store_product_path(@store, @product)
        @product_sizes = @product.sizes.order(created_at: :desc)
        @category_product = @product.category_products.all
    end

    def edit
        add_breadcrumb @store.name, store_products_path(@store)
        @product_name = 'Modificar ' + @product.name
        add_breadcrumb @product_name, edit_store_product_path(@store, @product)
    end

    def update  
        @categories = Category.all
        if @product.update(product_params) 
            @product.category_products.destroy_all
            if category_params.present?
                category_params.each do |category|
                    @category_product = @product.category_products.create(category_id: category)
                end
            end
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
        add_breadcrumb @store.name, store_products_path(@store)
        add_breadcrumb @product.name, store_product_path(@store, @product)
        add_breadcrumb 'Nueva imagen', new_product_images_path(@store, @product)
    end
    
    def create_images      
        if imgs_params.present?
            imgs_params.each do |image|
                @product.images.attach(image)
            end
        end
        redirect_to product_images_path(@store, @product) 
    end

    def show_images     
        add_breadcrumb @store.name, store_products_path(@store)
        add_breadcrumb @product.name, store_product_path(@store, @product)
        add_breadcrumb 'Imágenes', product_images_path(@store, @product)
    end

    def delete_image     
        @image = ActiveStorage::Attachment.find(img_id)
        @image.purge_later
        redirect_to product_images_path(@store, @product) 
    end

    def edit_image
        add_breadcrumb @store.name, store_products_path(@store)
        add_breadcrumb @product.name, store_product_path(@store, @product)
        @image = ActiveStorage::Attachment.find(img_id)
        add_breadcrumb 'Modificar imagen', edit_product_image_path(@store, @product, @image)
    end

    def update_image      
        @image = ActiveStorage::Attachment.find(img_id)
        @image.purge_later
        @product.images.attach(img_params)
        redirect_to product_images_path(@store, @product) 
    end

    def image_principal      
        @image = ActiveStorage::Attachment.find(img_id)
        if @product.images.attached? 
            @product.images.each do |image|             
                @image2 = ActiveStorage::Attachment.find(image.id)
                @image2.update_attribute(:main, false)
                if @image.id == image.id
                    @image2.update_attribute(:main, true)
                end 
            end
        end
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
            params.require(:product).permit(:name, :description, :sku, :state)
        end

        def img_params
            params[:image]
        end

        def imgs_params
            params[:images]
        end

        def img_id
            params[:image_id]
        end

        def category_params
            params[:product][:category_ids]
        end
end