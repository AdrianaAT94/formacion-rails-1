class SlidersController < ApplicationController
    
    def index
        @sliders = Slider.all
    end

    def new
        @slider = Slider.new
    end
    
    def create    
        @slider = Slider.new(slider_params)  
        if params[:images].present?
            params[:images].each do |image|
                @slider.images.attach(image)
            end
        end
        redirect_to sliders_path
    end

    def show_images     
    end

    def delete_image     
        @image = ActiveStorage::Attachment.find(params[:image_id])
        @image.purge_later
        redirect_to sliders_path
    end

    def edit_image
        @image = ActiveStorage::Attachment.find(params[:image_id])
    end

    def update_image      
        @image = ActiveStorage::Attachment.find(params[:image_id])
        @image.purge_later
        @slider.images.attach(params[:images])
        redirect_to sliders_path
    end

    private        
        def slider_params
            params.require(:slider).permit(:name)
        end

end
