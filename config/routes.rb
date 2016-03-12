Rails.application.routes.draw do
  resources :elections, only:[:show]
  resources :election_list, only: [:show]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # resources :elections
  #root :to => redirect('/dashboard/home')
  get "/dashboard/*page" => "elections#show"
  get "/election_show_elections" => "elections#show_elections"
  match "/election_add_election" => "elections#show_elections_add", via: [:get,:post]
  # match "/election_delete_election" => "elections#show_elections_delete", via: [:get,:post]
  match "/election_add_position" => "elections#show_positions_add", via: [:get,:post]
  # match "/election_delete_position" => "elections#show_positions_delete", via: [:get,:post]
  
  root :to => redirect("/dashboard/home")

  # # get "/loginlogin"
 
  
  
  # get 'dashboard/'

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
