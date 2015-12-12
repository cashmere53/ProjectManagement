Rails.application.routes.draw do
  root :to => 'search#form'

  #ユーザ利用
  get 'search' => 'search#form'
  post 'search/form'
  get 'search/form'
  post 'search/show'
  get 'search/show' => 'search#form'
  post 'search/detail'
  get 'search/detail' => 'search#form'
  post 'search/logout'
  get 'search/logout' => 'search#form'

  #ユーザ周り
  get '/users/login' => 'users#login'
  post '/users/auth' => 'users#auth'
  get '/users/new' => 'users#new'
  post '/users/edit' => 'users#edit'
  post '/users/update' => 'users#update'
  delete '/users/destroy/:id' => 'users#destroy'
  get  '/users/avaliable/:link_pass' => 'users#avaliable'
  post '/users/confirm' => 'users#confirm'
  post '/users/complete' => 'users#complete'

  #企業周り
  get '/inc_accounts/login' => 'inc_accounts#login'
  get '/inc_accounts/new' => 'inc_accounts#new'
  post '/inc_accounts/edit' => 'inc_accounts#edit'
  post '/inc_accounts/update' => 'inc_accounts#update'
  delete '/inc_accounts/destroy/:id' => 'inc_accounts#destroy'
  post '/inc_accounts/auth' => 'inc_accounts#auth'
  post '/inc_accounts/logout' => 'inc_accounts#logout'
  get  '/inc_accounts/avaliable/:link_pass' => 'inc_accounts#avaliable'
  post '/inc_accounts/confirm' => 'inc_accounts#confirm'
  post '/inc_accounts/complete' => 'inc_accounts#complete'

  #物件周り
  get '/housing_databases/showTables/:id' => 'housing_databases#showTables', as: 'housing_databases_showTables'
 get '/housing_databases/registerDatabases/:id' => 'housing_databases#registerDatabases', as: 'housing_databases_registerDatabases'
 get '/housing_databases/details/:id' => 'housing_databases#details', as: 'housing_databases_details'
 get '/housing_databases/editDatabases/:id' => 'housing_databases#editDatabases',as: 'housing_databases_editDatabases'
 get '/housing_databases/:id/image/' => 'housing_databases#image',as: 'housing_databases_image'
 post '/housing_databases/registerDatabases/:id' => 'housing_databases#create'
 patch '/housing_databases/editDatabases/:id' => 'housing_databases#update'
 delete '/housing_databases/details/:id' => 'housing_databases#destroy',as:'housing_databases_destroy'

#広告周り
 get '/advertising_databases/showTables/:id' => 'advertising_databases#showTables',as:'advertising_databases_showTables'
 get '/advertising_databases/registerDatabases/:id' => 'advertising_databases#registerDatabases',as:'advertising_databases_registerDatabses'
 get '/advertising_databases/details/:id' => 'advertising_databases#details', as: 'advertising_databases_details'
 get '/advertising_databases/editDatabases/:id' => 'advertising_databases#editDatabases',as: 'advertising_databases_editDatabases'
 get '/advertising_databases/:id/image/' => 'advertising_databases#image',as: 'advertising_databases_image'
 post '/advertising_databases/registerDatabases/:id' => 'advertising_databases#create'
 patch '/advertising_databases/editDatabases/:id' => 'advertising_databases#update'
 delete '/advertising_databases/details/:id' => 'advertising_databases#destroy',as:'advertising_databases_destroy'

  resources :search do
    member { get :image }
  end
  resources :advertising_databases do
      member do
        get 'show_image'
      end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
