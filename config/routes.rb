Landshark::Application.routes.draw do

  get "home/index"
  root :to => 'pages#splash'
  
  devise_for :users, :controllers => {:registrations => "registrations"}
    get '/admin' => 'home#index'

  scope "/admin" do
    resources :users
    get '/dashboard' => 'home#index'
    resources :recipients
    resources :conversations
    resources :groups
    resources :messages
    match '/reminder_imports/review' => 'reminder_imports#review'
    resources :reminder_imports
    match '/reminders/new' => 'reminders#new'
    get '/reminders/:batch_id/edit' => 'reminders#edit'
    get '/reminders/:batch_id' => 'reminders#show' 
    put '/reminders/:batch_id/edit' => 'reminders#update'
    post '/reminders/:batch_id/edit' => 'reminders#update'
    resources :reminders
  end

  #project page
  match '/hsa' => 'pages#hsa'
  match '/documents' => 'pages#documents'

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
