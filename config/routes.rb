Rails.application.routes.draw do

  namespace :persons do
    get 'omniauth_callbacks/facebook'
    get 'omniauth_callbacks/vkontakte'
  end

  post 'ajax',to: 'days#ajax'

  resources :persons

  get   'persons/im', to: 'persons#im'   #, as: 'user_im'
  post  'persons/:id/edit', to: 'persons#update'


  root 'hello#index'
  devise_for :users, :controllers => {  :omniauth_callbacks => "persons/omniauth_callbacks" }



  #resources :persons, :only => [:index, :destroy]
  #root :to => 'persons#index'


  #resources :persons do
    #root :to => 'persons#index'
    #devise_for :persons
  #end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end


  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
