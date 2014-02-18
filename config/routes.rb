Promptly::Application.routes.draw do
  root :to => 'pages#splash'
  
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit',   :as => 'edit_user_registration'
    put 'users'      => 'devise/registrations#update', :as => 'user_registration'
  end

  namespace :admin do
    root to: 'dashboard#index', as: 'dashboard'


    resources :organizations do
      resources :users
      resources :recipients
      resources :conversations
      resources :groups
      resources :messages
      resources :organizations
      resources :reminders do
        collection do
          get :confirm
        end
      end
    end

  end


  #project page
  match '/hsa'       => 'pages#hsa'
  match '/documents' => 'pages#documents'

  #autoresponse
  match '/handle-incoming-sms'  => 'auto_response#handle_incoming_sms'
  match '/handle-incoming-call' => 'auto_response#handle_incoming_call'
  match '/handle-input'         => 'auto_response#handle_input'
  match '/english-response'     => 'auto_response#english_response'
  match '/spanish-response'     => 'auto_response#spanish_response'
  match '/cantonese-response'   => 'auto_response#cantonese_response'
end
