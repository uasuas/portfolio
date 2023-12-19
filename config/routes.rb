Rails.application.routes.draw do

  devise_for :customers,skip: %i[passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: %i[registrations passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  devise_scope :customer do
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  root 'public/homes#top'
  get 'about', to: 'public/homes#about'
  get 'search', to: "public/line_plans#search"
  # publicをURLに含めたくない為、scope moduleを使用。
  scope module: :public do
    resources :companies, only: %i[index show]
    resources :inquiries, only: %i[create]
    resources :line_plans, only: %i[index show] do
      resources :reviews, only: %i[create destroy]
    end
    # indexとidはトラブルの元となる為、resourceを使用。
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
  # adminにいることが分かりやすくする為、namespaceを使用。
  namespace :admin do
    root "homes#top"
    get "inquiries/show", to: "inquiries#show"

    resources :companies, except: :index
    resources :line_plans, except: :index
    resources :reviews, only: %i[destroy]
    resources :inquiries, only: %i[show update destroy]
    resources :customers, except: :destroy
  end
  # *unmatched_routeにて存在しないURLが入力された場合、application_controllerのredirect_to_rootアクションを呼び出す。
  get '*unmatched_route', to: 'application#redirect_to_root'

end
