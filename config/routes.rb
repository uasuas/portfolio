Rails.application.routes.draw do


  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :admin do
    get 'line_plans/new'
    get 'line_plans/index'
    get 'line_plans/show'
    get 'line_plans/edit'
  end
  namespace :admin do
    get 'companies/new'
    get 'companies/index'
    get 'companies/show'
    get 'companies/edit'
  end
  devise_for :customers,skip: %i[passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: %i[registrations passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root 'public/homes#top'
  get 'about', to: 'public/homes#about'
  # publicをURLに含めたくない為、scope moduleを使用
  scope module: :public do
    resources :companies, only: %i[index show]
    resources :line_plans, only: %i[index show]
    resources :reviews, only: %i[creat update destroy]
    # indexとidはトラブルの元となる為resourceを使用
    resource :customers do
      collection do
        get :mypage, to: "customers#show"
        get "mypage/edit", to: "customers#edit"
        patch "mypage/update", to: "customers#update"
        get :confirm
        patch :leave
      end
    end
    # get 'searches/search', as: "customer_search"
  end
  # adminにいることが分かりやすくする為namespaceを使用
  namespace :admin do
    root "inquiries#index"
    get "inquiries/show", to: "inquiries#show"

    resources :coustomers, except: :destroy
    resources :companies
    resources :line_plans
    resources :reviews, only: %i[update destroy]
  end

end
