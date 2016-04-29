Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :elections, only:[:show]
  resources :election_list, only: [:show]
  
  get '/auth/google_oauth2/callback', to: 'sessions#create', as: 'oauth_callback_test'
  get '/auth/:provider/callback', to: 'sessions#create', as: 'oauth_callback_test2'
  get '/auth/failure', to: redirect('/')
  get '/signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy, :test_super_admin]
  resources :home, only: [:show]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # resources :elections
  # root :to => redirect('/dashboard/home')
  match "/dashboard/*page" => "elections#show", via: [:get,:post]
  get "/election_show_elections" => "elections#show_elections"
  get "/super_admin_setup" => "sessions#test_super_admin"
  get "/nonsuperadmin_setup" => "sessions#test_nonsuper_admin"
  match "/election_add_individual" => "elections#add_individual", via: [:get,:post]
  match "election_delete_individual" => "elections#delete_individual", via: [:get,:post]


  get "/login" => "elections#login"
  match "/election_add_organization" => "elections#show_organizations_add", via: [:get,:post]
  match "/election_add_election" => "elections#show_elections_add", via: [:get,:post]
  match "/election_delete_election" => "elections#show_elections_delete", via: [:get,:post]
  match "/election_add_position" => "elections#show_positions_add", via: [:get,:post]
  match "/election_delete_position" => "elections#show_positions_delete", via: [:get,:post]
  match "/election_dashboard" => "elections#dashboard", via: [:get,:post]
  match "/election_embed_livestream" => "elections#embed_livestream", via: [:get,:post]
  match "/election_show_nominations" => "elections#show_nominations", via: [:get,:post]
  match "/election_post_nominations" => "elections#post_nominations", via: [:get,:post]
  match "/election_settings" => "elections#show_settings", via: [:get,:post], as: :settings
  
  match "/election_show_vote" => "elections#show_vote", via: [:get,:post]
  match "/election_post_vote" => "elections#post_vote", via: [:get,:post]
  match "/election_show_results" => "elections#show_results", via: [:get,:post]
  
  get "/get_current_phase" => "elections#get_current_phase"
  match "/goto_next_phase" => "elections#goto_next_phase", via: [:get,:post]
  match "/get_user_prime" => "elections#get_user_prime", via: [:get,:post]
  
  match "/encryption_save" => "elections#encryption_save", via: [:get,:post]
  match "/show_modal" => "elections#show_modal", via: [:get,:post]
  root :to => redirect("/login")

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
