Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  # 10-5 演習1
  # namespace :admin, module: 'administration' do
  #   get 'blog/:year/:month/:mday' => 'articles#show',
  #       constraints: {year: /20\d\d/, month: /\d\d/, mday: /\d\d/ },
  #       as: :article
  # end
  # Prefix        Verb   URI Pattern                              Controller#Action
  # admin_article GET    /admin/blog/:year/:month/:mday(.:format) administration/articles#show {:year=>/20\d\d/, :month=>/\d\d/, :mday=>/\d\d/}


  config = Rails.application.config.baukis

  # ホスト名による制約 ※このホスト名でアクセスされた場合のみ以下のルーティングを適用する
  constraints host: config[:staff][:host]  do
    # ※config/environment/xxx.rbで設定したpathを適用する
    namespace :staff, path: config[:staff][:path] do
      # Staff::TopController#index
      root 'top#index'

      get 'login' => 'sessions#new', as: :login

      # 単数リソースで書き換え
      # post 'session' => 'sessions#create', as: :session
      # delete 'session' => 'sessions#destroy'
      resource 'session', only: [ :create, :destroy ]

      # 単数リソースである点に注意 ※controllerは staff/accounts と複数形になる
      resource :account, except: [ :new, :create, :destroy ]
    end
  end

  constraints host: config[:admin][:host]  do
    namespace :admin, path: config[:admin][:path] do
      root 'top#index'

      get 'login' => 'sessions#new', as: :login

      # 単数リソースで書き換え
      # post 'session' => 'sessions#create', as: :session
      # delete 'session' => 'sessions#destroy'
      resource 'session', only: [ :create, :destroy ]

      resources :staff_members
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root 'top#index'
    end
  end

  # rootを明示しないとデフォルトのindex.htmlが表示されてしまう
  root 'errors#not_found'

  # どれにもmatchしなかった場合、not_foundに流し込む
  # ※ActionController::RoutingErrorはルーティング処理で発生するエラーなのでrescue_fromでは捕捉できない。
  #   よってcontroller内で明示的にActionController::RoutingErrorをraiseし、rescue_fromで捕捉する
  get '*anything' => 'errors#not_found'

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
