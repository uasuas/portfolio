Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root 'public/homes#top'
  get 'about', to: 'public/homes#about'

  scope module: :public do
    resources :companies, only: %i[index show]
    resources :line_plans, only: %i[index show]
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

  namespace :admin do
    root "inquiries#index"
    get "inquiries/show", to: "inquiries#show"
  end

end
