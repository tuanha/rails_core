Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "devise/user/sessions", registrations: "devise/user/registrations", passwords: "devise/user/passwords"}

  root 'user/pages#welcome'

  namespace :admin do
    root 'pages#dashboard'

    resources :backend_menus do
      collection do
        post 'ajax_update_position'
      end
    end
    resources :users do
      collection do
        post 'assign_role'
      end
    end
  end

  devise_scope :user do
    get "admin/sign_in" => "devise/admin/sessions#new"
    get "admin/sign_up" => "devise/admin/registrations#new"
    get "admin/password/new" => "devise/admin/passwords#new"
    get "admin/password/edit" => "devise/admin/passwords#edit"
  end

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
