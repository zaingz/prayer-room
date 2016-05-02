Rails.application.routes.draw do
  root 'rooms#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :photos
  resources :rooms
  get 'rooms/report/:id' => 'rooms#report' , :as => 'report'
  post 'report/:id' => 'rooms#creport' , :as => 'report_create'
  get 'admin/users' => 'admin#user' , :as => 'users'
  get 'admin/user/ban/:id' => 'admin#user_ban'
  get 'admin/user/ban' , :as => 'ban'
  delete 'user/:id' => 'admin#user_del' ,:as => 'destroy_user'
  get 'admin/user/edit/:id' => 'admin#user_edit' ,:as => 'edit_user'
  patch 'admin/user/update/:id' => 'admin#user_update' , :as => 'user'
  get 'admin/room/pending' => 'admin#rooms' ,:as => 'admin_rooms'

  get 'admin/room/approve/:id' => 'admin#approve_room' , :as => 'approve'
  get 'admin/room/reject/:id' => 'admin#reject_room' , :as => 'reject'
  get 'admin/room' => 'admin#room_entries' ,:as => 'admin_room_entries'
  get 'admin/reports' => 'admin#reports'

  get 'room/search' => 'search#search_by_name'
  get 'room/search_all' => 'search#search'
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
