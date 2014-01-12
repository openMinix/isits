Sharknet::Application.routes.draw do
  
   get "webservices/showwork"
  get "webservices/showvacation"
  resources :user_jobs

  resources :departments

  resources :divisions

  resources :projects

  resources :clients

# reports for department head
  get 'activities/pdf_dept_users' => 'activities#pdf_dept_users', :as => :pdf_dept_users
  get 'activities/pdf_dept_projects' => 'activities#pdf_dept_projects', :as => :pdf_dept_projects	
  get 'activities/pdf_dept_periods' => 'activities#pdf_dept_periods', :as => :pdf_dept_periods

  get 'activities/departments' => 'activities#departments_search', :as => :activities_departments
  get 'activities/departments_result' => 'activities#departments_result', :as => :activities_depresults

  get 'activities/departments_project' => 'activities#departments_project_search', :as => :activities_departments_project
  get 'activities/departments_project_result' => 'activities#departments_project_result', :as => :activities_depresults_project

  get 'activities/departments_period' => 'activities#departments_period_search', :as => :activities_departments_period
  get 'activities/departments_period_result' => 'activities#departments_period_result', :as => :activities_depresults_period


#reports for division head

  get 'activities/pdf_div_users' => 'activities#pdf_div_users', :as => :pdf_div_users	
  get 'activities/pdf_div_projects' => 'activities#pdf_div_projects', :as => :pdf_div_projects		
  
  get 'activities/divisions_users' => 'activities#divisions_users_search', :as => :activities_divisions_users
  get 'activities/divisions_users_result' => 'activities#divisions_users_result', :as => :activities_divresults_users

  get 'activities/divisions_project' => 'activities#divisions_projects_search', :as => :activities_divisions_project
  get 'activities/divisions_project_result' => 'activities#divisions_projects_result', :as => :activities_divresults_project

# reports for director  
  get 'activities/pdf_director_users' => 'activities#pdf_director_users', :as => :pdf_director_users
  get 'activities/pdf_director_projects' => 'activities#pdf_director_projects', :as => :pdf_director_projects
  get 'activities/pdf_director_clients' => 'activities#pdf_director_clients', :as => :pdf_director_clients

  get 'activities/director_users' => 'activities#director_users_search', :as => :activities_director_users
  get 'activities/director_result' => 'activities#director_users_result', :as =>:activities_dirresults_users

  get 'activities/director_project' => 'activities#director_projects_search', :as => :activities_director_project
  get 'activities/director_project_result' => 'activities#director_projects_result', :as => :activities_dirresults_project

  get 'activities/divisions_clients' => 'activities#director_clients_search', :as => :activities_director_clients
  get 'activities/director_clients_result' => 'activities#director_clients_result', :as => :activities_dirresults_clients







  resources :activities

  get 'sheetfile/:id/duplicate' => 'sheetfiles#duplicate', :as => :duplicate_sheetfile
  resources :sheetfiles


  get 'timesheets/divisions' => 'timesheets#divisions_index', :as => :timesheets_divisions
  get 'timesheets/departments' => 'timesheets#departments_index', :as => :timesheets_departments
  get 'timesheets/director' => 'timesheets#director_index', :as => :timesheets_director

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  devise_scope :user do
  resources :timesheets

    devise_for :users , :controllers => { :registrations => 'memberships' }
    get 'users/:id/edit' => 'memberships#edit', :as => :memberships_edit
    match 'users/:id/update'=>'memberships#update', :via => [:post,:patch], :as => :memberships_update
    match 'users/:id' => 'memberships#destroy', :via => :delete, :as => :admin_destroy_user

    root to: "devise/sessions#new"

    get 'memberships/index' => 'memberships#index'
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
