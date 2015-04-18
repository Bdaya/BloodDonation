Faselty::Application.routes.draw do

  devise_for :admins
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations"}



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => "contents#index"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  resources :contents, only: [:index] do
    collection do
      get :about
      get :donor_info
      get :donation_info
      get :blood_info
      get :patient_info
      get :news
      get :contact
    end
  end

  resources :users, only: [:show, :update] do
    member do
      get :settings
      get :reports
      get :donations
      post :pause
      post :unpause
      post :update_last_donated
      post :update_location
    end
  end

  resources :requests, except: [:delete] do
    member do
      post :reopen
      get :log_in
      post :authenticate
      post :update_location
      post :stop
      post :reply
      get :replies
    end
    collection do
      get :receive_sms_requests
    end
  end

  resources :replies do
    member do
      post :report
      post :confirm
      post :cancel
    end
  end
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
