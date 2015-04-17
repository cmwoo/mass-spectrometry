MassSpec::Application.routes.draw do

  get "user_uploads/uploads"

  devise_for :users

  get "general/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  match 'mass_params/update_params' => 'mass_params#update_params', :as => :update_params
  match 'mass_params/choose' => 'mass_params#choose', :as => :choose_params
  match '/mass_data/choose' => 'mass_data#choose', :as => :choose_data
  match '/mass_data/update_choice' => 'mass_data#update_choice', :as => :update_choice
  resources :mass_data, :mass_params
  match '/review' => 'results#review', :as => :review
  get '/finish' => 'results#index', :as => :finish_index
  match '/review/upload' => 'general#upload', :as => :upload
  match '/mass_data/upload' => 'mass_data#upload', :as => :upload_data
  match '/mass_params/upload' => 'mass_params#upload', :as => :upload_params
  match '/about' => 'general#about', :as => :about
  match '/downloads' => 'general#downloads', :as => :downloads
  match '/citations' => 'general#citations', :as => :citations
  match '/examples' => 'general#examples', :as => :examples
  match '/uploads' => 'user_uploads#uploads', :as => :uploads
  match '/instructions' => 'general#instructions', :as => :instructions
  root :to => 'general#index'

  post '/finish' => 'general#finish', :as => :post_finish

  match '/downloads/:file' => 'general#download_file', :as => :download_file, :constraints  => { :file => /[0-z\.]+/ }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
