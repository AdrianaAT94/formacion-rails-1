class SlidersController < ApplicationController
    before_action :find_slider, except: [:index, :new, :create]
    
    def index
        @sliders = Slider.all
    end

    def new
        @slider = Slider.new
    end
    
    def create    
        @slider = Slider.new(slider_params)
        if @slider.save 
            if params[:image].present?
                @slider.image.attach(params[:image])
            end
            redirect_to sliders_path
        else
            render 'new'
        end
    end

    def destroy     
        @image = ActiveStorage::Attachment.find(@slider.image.id)
        @image.purge_later
        redirect_to sliders_path 
    end

    def edit
    end

    def update    
        @slider.update(slider_params) 
        @image = ActiveStorage::Attachment.find(@slider.image.id)        
        if params[:image].present?
            @image.update(params[:image])
        end
        redirect_to sliders_path
    end

    private
        def find_slider
            @slider = Slider.find(params[:id])
        end

        def slider_params
            params.require(:slider).permit(:name, :image)
        end
end
