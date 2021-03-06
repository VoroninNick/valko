Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

  get 'vyrobnictvo-prodazh-montazh-pidvikonnykiv' => 'main#about', as: :about

  get 'informaciia' => 'main#publications', as: :information
  get 'informaciia/:title' => 'main#publication', as: :one_publication

  get 'testimonials' => 'testimonial#list', as: :testimonials

  get 'aktcii' => 'main#promotions', as: :promotions
  get 'aktcii/:title' => 'main#one_promotions', as: :one_promotions

  get 'kontakty' => 'main#contacts', as: :contacts

  get 'dostavka-i-oplata' => 'main#warranty', as: :warranty

  get 'pidvikonnja-vidlyvy' => 'main#windowsill', as: :windowsill
  get 'pidvikonnja-vidlyvy/:title' => 'main#one_windowsill', as: :one_windowsill
  get 'gag/:title' => 'main#gag', as: :one_gag

  get 'pokrivlja-ogorozhi' => 'roof_railing#index', as: :roof_rail
  get 'pokrivlja-ogorozhi/profnastyl-metaloprofil' => 'roof_railing#deck_list', as: :roof_rail_decking
  get 'pokrivlja-ogorozhi/profnastyl-metaloprofil/:title' => 'roof_railing#decking', as: :one_decking

  # 17.08.16
  get 'pokrivlja-ogorozhi/metalocherepitcja' => 'roof_railing#metal_tile_list', as: :metal_tile
  get 'pokrivlja-ogorozhi/metalocherepitcja/:title' => 'roof_railing#metal_tile', as: :metal_tile_item
  # get 'pokrivlja-ogorozhi/metalocherepitcja/item' => 'roof_railing#metal_tile', as: :metal_tile_item

  get 'pokrivlja-ogorozhi/lystovyj-metal' => 'roof_railing#sheet_metal_list', as: :sheet_metal
  get 'pokrivlja-ogorozhi/lystovyj-metal/:title' => 'roof_railing#sheet_metal', as: :sheet_metal_item
  # get 'pokrivlja-ogorozhi/lystovyj-metal/item' => 'roof_railing#sheet_metal', as: :sheet_metal_item

  get 'pokrivlja-ogorozhi/pokrivelni-dobirni-elementy' => 'roof_railing#choicest_items', as: :choicest_items
  get 'pokrivlja-ogorozhi/pokrivelni-dobirni-elementy/the-roof' => 'roof_railing#choicest_roof_items', as: :choicest_roof_items
  get 'pokrivlja-ogorozhi/pokrivelni-dobirni-elementy/the-fence' => 'roof_railing#choicest_fence_items', as: :choicest_fence_items
  get 'pokrivlja-ogorozhi/pokrivelni-dobirni-elementy/:title' => 'roof_railing#choicest_item', as: :choicest_item

  # mounting and sealants
  get 'pokrivlja-ogorozhi/kriplennja-germetyka-dlja-pokrivli' => 'roof_railing#mounting_and_sealants', as: :mounting_and_sealants
  get 'pokrivlja-ogorozhi/kriplennja-germetyka-dlja-pokrivli/hermetyky' => 'roof_railing#sealants', as: :sealants
  get 'pokrivlja-ogorozhi/kriplennja-germetyka-dlja-pokrivli/hermetyky/:title' => 'roof_railing#sealant', as: :sealant
  get 'pokrivlja-ogorozhi/kriplennja-germetyka-dlja-pokrivli/kriplennya' => 'roof_railing#mounting', as: :fasteners
  get 'pokrivlja-ogorozhi/kriplennja-germetyka-dlja-pokrivli/kriplennya/:title' => 'roof_railing#fastener', as: :fastener

  # roofing membrane
  get 'pokrivlja-ogorozhi/pokrivelni-plivky' => 'roof_railing#roofing_membrane', as: :roofing_membrane
  get 'pokrivlja-ogorozhi/pokrivelni-plivky/parobaryer' => 'roof_railing#vapour_barrier', as: :vapour_barrier
  get 'pokrivlja-ogorozhi/pokrivelni-plivky/parobaryer/:title' => 'roof_railing#vapour_barrier_item', as: :vapour_barrier_item

  get 'pokrivlja-ogorozhi/pokrivelni-plivky/hidrobaryer' => 'roof_railing#hydro_barrier', as: :hydro_barrier
  get 'pokrivlja-ogorozhi/pokrivelni-plivky/hidrobaryer/:title' => 'roof_railing#hydro_barrier_item', as: :hydro_barrier_item

  get 'pokrivlja-ogorozhi/pokrivelni-plivky/membrana' => 'roof_railing#membrane', as: :membrane
  get 'pokrivlja-ogorozhi/pokrivelni-plivky/membrana/:title' => 'roof_railing#membrane_item', as: :membrane_item

  # roof windows
  get 'pokrivlja-ogorozhi/mansardni-vikna-daxovi' => 'roof_railing#skylights', as: :skylights
  get 'pokrivlja-ogorozhi/mansardni-vikna-daxovi/:producer' => 'roof_railing#skylight', as: :skylight
  get 'pokrivlja-ogorozhi/mansardni-vikna-daxovi/:producer/:title' => 'roof_railing#skylight_item', as: :skylight_item

  get 'moskitna-sitka' => 'mosquito#index', as: :mosquito_grid
  get 'moskitna-sitka/window' => 'mosquito#window', as: :mosquito_grid_window
  get 'moskitna-sitka/window/:title' => 'mosquito#window_item', as: :one_mosquito_window

  get 'moskitna-sitka/door' => 'mosquito#door', as: :mosquito_grid_doors
  get 'moskitna-sitka/door/:title' => 'mosquito#door_item', as: :one_mosquito_door
  get 'moskitna-sitka/rolling' => 'mosquito#rolling', as: :mosquito_grid_rolling
  get 'moskitna-sitka/rolling/:title' => 'mosquito#rolling_item', as: :one_mosquito_rolling
  get 'moskitna-sitka/sliding' => 'mosquito#sliding', as: :mosquito_grid_sliding
  get 'moskitna-sitka/sliding/:title' => 'mosquito#sliding_item', as: :one_mosquito_sliding

  # 28.09.16
  get 'mataloplastykovi-vikna-i-dveri' => 'window_and_door#index', as: :window_and_door
  post 'wd_order_product' => 'window_and_door#order_product', as: :windowsill_and_door_ordering

  get 'basket' => 'main#basket'
  post 'recently_viewed' => 'main#recently_viewed'

  post 'offers_and_comments' => 'main#offers_and_comments'
  post 'contact_form' => 'main#contact_form'
  post 'call_order' => 'main#call_order'
  post 'order_product' => 'main#order_product'


  get 'finish_step_basket/:id' => 'main#finish_step_basket', as: :basket_items_list

  get 'terms-of-use' => 'main#terms'
  get 'warranty' => 'main#warranty'

  get 'search' => 'main#search'
  get 'sitemap' => 'main#sitemap'

  get 'dev' => 'main#dev'
  get 'dev2' => 'main#dev2'
  get 'dev3' => 'main#dev3'

  post 'get_rr_options/:key' =>'roof_railing#get_rr_options', as: :get_rr_option
  post 'get_metal_tile_options/:key' =>'roof_railing#get_metal_tile_options', as: :get_mt_option
  post 'get_metal_sheet_options/:key' =>'roof_railing#get_metal_sheet_options', as: :get_ms_option
  post "get_product_options/:type/:name" =>'roof_railing#get_product_options', as: :get_product_option
  post "get_fastener_options/:type/:name" =>'roof_railing#get_fastener_options', as: :get_fastener_option

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

  get "*any", via: :all, to: "errors#not_found"
end
