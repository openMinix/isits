Sharknet::Application.routes.draw do

  resources :user_jobs

  resources :departments

  resources :divisions

  resources :projects

  resources :clients

  get 'activities/divisions' => 'activities#divisions_search', :as => :activities_divisions
  get 'activities/departments' => 'activities#departments_search', :as => :activities_departments
  get 'activities/director' => 'activities#director_search', :as => :activities_director

  get 'activities/divisions_result' => 'activities#divisions_result', :as => :activities_divresults
  get 'activities/departments_result' => 'activities#departments_result', :as => :activities_depresults
  get 'activities/director_result' => 'activities#director_result', :as => :activities_dirresults


  resources :activities

  resources :sheetfiles


  get 'timesheets/divisions' => 'timesheets#divisions_index', :as => :timesheets_divisions
  get 'timesheets/departments' => 'timesheets#departments_index', :as => :timesheets_departments
  get 'timesheets/director' => 'timesheets#director_index', :as => :timesheets_director

  devise_for :users , :controllers => { :registrations => 'memberships' } 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  devise_scope :user do
  resources :timesheets

    root to: "devise/sessions#new"

    get 'memberships/index' => 'memberships#index'
    match 'users/:id' => 'memberships#destroy', :via => :delete, :as => :admin_destroy_user
  end

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
