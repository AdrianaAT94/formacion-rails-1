class SlidersController < ApplicationController
    before_action :find_slider, except: [:index, :new, :create]
    add_breadcrumb "Slider", :sliders_path
    
    def index
        @sliders = Slider.all
    end

    def new        
        add_breadcrumb "Nueva imagen slider", new_slider_path
        @slider = Slider.new
    end
    
    def create    
        @slider = Slider.new(slider_params)
        if @slider.save 
            if img_params.present?
                @slider.image.attach(img_params)
            end
            redirect_to sliders_path
        else
            render 'new'
        end
    end

    def destroy     
        @image = ActiveStorage::Attachment.find(@slider.image.id)
        @image.purge_later
        @slider.destroy
        redirect_to sliders_path 
    end

    def edit
        @slider_name = 'Modificar ' + @slider.name
        add_breadcrumb @slider_name, edit_slider_path(@slider)
    end

    def update    
        @slider.update(slider_params) 
        @image = ActiveStorage::Attachment.find(@slider.image.id)        
        if img_params.present?
            @image.update(img_params)
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

        def img_params
            params[:image]
        end
end
