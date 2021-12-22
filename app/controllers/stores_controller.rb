class StoresController < ApplicationController
    before_action :find_store, except: [:index, :new, :create]
    add_breadcrumb "Tiendas registradas", :stores_path

    def index
        @stores = Store.all
    end
   
    def new
        add_breadcrumb "Nueva tienda", new_store_path
        @store = Store.new
    end

    def create
        @store = Store.new(store_params)
        if @store.save 
            redirect_to stores_path
        else
            render 'new'
        end
    end

    def show
        @store_name = @store.name + ' : Productos'
        add_breadcrumb @store_name, store_path(@store)
        @store_products = @store.products.order(created_at: :desc)
    end

    def edit 
        @store_name = 'Modificar ' + @store.name
        add_breadcrumb @store_name, edit_store_path(@store)
    end

    def update  
        if @store.update(store_params) 
            redirect_to stores_path
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
