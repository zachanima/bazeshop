Bazeshop::Application.routes.draw do
  namespace :admin do
    root to: 'shops#new'
    resources :option_sets do
      collection do
        post 'sort'
      end
    end
    resources :products do
      collection do
        get 'all'
      end
    end
    resources :shops do
      resources :access_groups
      resources :categories do
        collection do
          post 'sort'
        end
      end
      resources :products do
        collection do
          post 'sort'
          post 'edit_multiple'
        end
        resources :images do
          collection do
            post 'sort'
          end
        end
      end
      resources :users do
        collection do
          post 'edit_multiple'
          post 'import'
        end
      end
      resources :orders
      resources :fields
    end
  end

  resources :shops do
    resources :categories
    resources :line_items do
      member do
        put :increment
        put :decrement
      end
    end
    resources :orders
    resources :products do
      resources :line_items
    end
    member do
      devise_for :users, controllers: { sessions: 'user/sessions' }
    end
    resources :users do
      collection do
        post :activate
        post :deactivate
      end
    end
    member do
      get :pay
      get :payment_ok
      get :payment_fail
      get :terms
      post :switch
      post :save_fields
    end
  end

  root to: 'admin/shops#new'

  match '/:id', to: 'shops#show'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
