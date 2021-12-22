Rails.application.routes.draw do
  resources :sliders
  resources :categories
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :stores do
    resources :products do
      resources :sizes
    end
  end

  root :to => "welcome#index"
  # get 'tiendas', to: 'welcome#stores', as: :tiendas
  # get 'tiendas/:store_id', to: 'welcome#products_store', as: :tienda
  get 'productos', to: 'welcome#products', as: :productos
  get 'productos/:product_id', to: 'welcome#product', as: :producto
  # get 'tiendas/:store_id/productos', to: 'welcome#products_store', as: :productos_tiendas
  # get 'tiendas/:store_id/productos/:product_id', to: 'welcome#product_store', as: :producto_tienda

  get 'stores/:store_id/products/:id/images', to: 'products#show_images', as: :product_images
  get 'stores/:store_id/products/:id/images/new_images', to: 'products#new_images', as: :new_product_images
  get 'stores/:store_id/products/:id/images/edit_image/:image_id', to: 'products#edit_image', as: :edit_product_image
  get 'stores/:store_id/products/:id/images/image_principal/:image_id', to: 'products#image_principal', as: :product_image_principal
  post 'stores/:store_id/products/:id/images/create_images', to: 'products#create_images', as: :create_product_images
  post 'stores/:store_id/products/:id/images/update_image/:image_id', to: 'products#update_image', as: :update_product_image
  delete 'stores/:store_id/products/:id/images/delete_image/:image_id', to: 'products#delete_image', as: :delete_product_image
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  match '/404', via: :all, to: 'errors#not_found'
  match '/422', via: :all, to: 'errors#unprocessable_entity'
  match '/500', via: :all, to: 'errors#server_error'

end
