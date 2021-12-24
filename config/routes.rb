Rails.application.routes.draw do
  resources :sliders
  resources :categories
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :products do
    resources :sizes
  end

  root :to => "welcome#index"
  get 'productos', to: 'welcome#products', as: :productos
  get 'productos/:id', to: 'welcome#product', as: :producto

  get 'products/:id/images', to: 'products#show_images', as: :product_images
  get 'products/:id/images/new_images', to: 'products#new_images', as: :new_product_images
  get 'products/:id/images/edit_image/:image_id', to: 'products#edit_image', as: :edit_product_image
  get 'products/:id/images/image_principal/:image_id', to: 'products#image_principal', as: :product_image_principal
  post 'products/:id/images/create_images', to: 'products#create_images', as: :create_product_images
  post 'products/:id/images/update_image/:image_id', to: 'products#update_image', as: :update_product_image
  delete 'products/:id/images/delete_image/:image_id', to: 'products#delete_image', as: :delete_product_image
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get 'cart', to: 'welcome#cart'
  get 'order', to: 'welcome#order'
  post 'productos/:id/add_to_cart', to: 'welcome#add_to_cart'
  post 'cart/buy_cart', to: 'welcome#buy_cart'
  delete 'cart', to: 'welcome#delete_cart_item', as: :delete_cart_item  
  post 'cart', to: 'welcome#modify_items', as: :modify_items
  

  match '/404', via: :all, to: 'errors#not_found'
  match '/422', via: :all, to: 'errors#unprocessable_entity'
  match '/500', via: :all, to: 'errors#server_error'

end
