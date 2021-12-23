class ProductsController < ApplicationController
    before_action :find_product, except: [:index, :new, :create]

    def index
        add_breadcrumb 'Productos', products_path
        @products = Product.search_category_id(category_id).order(created_at: :desc)
        @categories = Category.all
    end

    def new
        add_breadcrumb 'Nuevo producto', new_product_path
        @product = Product.new
    end

    def create
        @product = Product.create(product_params)
        if @product.save
            if category_params.present?
                category_params.each do |category|
                    @category_product = @product.category_products.create(category_id: category)
                end
            end
            redirect_to products_path
        else
            render 'new'
        end
    end

    def show
        add_breadcrumb @product.name, product_path(@product)
        @product_sizes = @product.sizes.order(created_at: :desc)
        @category_product = @product.category_products.all
    end

    def edit
        @product_name = 'Modificar ' + @product.name
        add_breadcrumb @product_name, edit_product_path(@product)
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
            redirect_to product_path(@product)
        else
            render 'edit'
        end        
    end

    def destroy   
        @product.destroy
        redirect_to products_path
    end

    def new_images
        add_breadcrumb @product.name, product_path(@product)
        add_breadcrumb 'Nueva imagen', new_product_images_path(@product)
    end
    
    def create_images      
        if imgs_params.present?
            imgs_params.each do |image|
                @product.images.attach(image)
            end
        end
        redirect_to product_images_path(@product) 
    end

    def show_images     
        add_breadcrumb @product.name, product_path(@product)
        add_breadcrumb 'Imágenes', product_images_path(@product)
    end

    def delete_image     
        @image = ActiveStorage::Attachment.find(img_id)
        @image.purge_later
        redirect_to product_images_path(@product) 
    end

    def edit_image
        add_breadcrumb @product.name, product_path(@product)
        @image = ActiveStorage::Attachment.find(img_id)
        add_breadcrumb 'Modificar imagen', edit_product_image_path(@product, @image)
    end

    def update_image      
        @image = ActiveStorage::Attachment.find(img_id)
        @image.purge_later
        @product.images.attach(img_params)
        redirect_to product_images_path(@product) 
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
        redirect_to product_images_path(@product) 
    end

    private
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

        def category_id
          params[:category_id]
        end
end