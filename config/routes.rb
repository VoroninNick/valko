Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

  get 'about' => 'main#about'

  get 'information' => 'main#publications'
  get 'information/:title' => 'main#publication', as: :one_publication

  get 'promotions' => 'main#promotions'
  get 'promotions/:title' => 'main#one_promotions', as: :one_promotions

  get 'contacts' => 'main#contacts'

  get 'warranty' => 'main#warranty'

  get 'windowsill' => 'main#windowsill'
  get 'windowsill/:title' => 'main#one_windowsill', as: :one_windowsill
  get 'gag/:title' => 'main#gag', as: :one_gag

  get 'basket' => 'main#basket'
  post 'recently_viewed' => 'main#recently_viewed'

  post 'offers_and_comments' => 'main#offers_and_comments'
  post 'contact_form' => 'main#contact_form'
  post 'call_order' => 'main#call_order'
  post 'order_product' => 'main#order_product'

  get 'finish_step_basket/:id' => 'main#finish_step_basket', as: :basket_items_list

  get 'terms-of-use' => 'main#terms'
  get 'warranty' => 'main#warranty'

  get 'dev' => 'main#dev'

  resources :line_items
  resources :carts
  # get 'windowsill/item' => 'main#one_windowsill', as: :one_windowsill

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
