class StoresController < ApplicationController
    before_action :find_store, except: [:index, :new, :create]

    def index
        @stores = Store.all
    end
   
    def new
        @store = Store.new
    end

    def create
        @store = Store.new(store_params)
        if @store.save 
            redirect_to @store
        else
            render 'new'
        end
    end

    def show
    end

    def edit 
    end

    def update  
        if @store.update(store_params) 
            redirect_to @store
        else
            render 'edit'
        end        
    end

    def destroy        
        @store.destroy
        redirect_to stores_path
    end

    private  
        def find_store
            @store = Store.find(params[:id])
        end
        
        def store_params
            params.require(:store).permit(:name)
        end
end
