Rails.application.routes.draw do
  resources :categories
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :stores do
    resources :products do
      resources :photos
      resources :sizes
    end
  end

  root :to => "welcome#index"

  get 'tiendas/:store_id/productos', to: 'welcome#products_store', as: :productos
  get 'tiendas/:store_id/productos/:product_id', to: 'welcome#product_store', as: :producto
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
