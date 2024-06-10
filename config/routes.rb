Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # ユーザー側
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    root 'homes#top'
    
    get 'about' => 'homes#about'
    get 'users/mypage' => 'users#show', as: 'mypage'
    resources :users, only: [:show, :edit, :update, :destroy] do
      resource :relationship, only: [:create, :destroy]
        get "followers" => "relationships#followers", as: "followers"
        get "followeds" => "relationships#followeds", as: "followeds"
    end
    resources :posts do
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :update, :destroy]
      member do
        get 'favorites', to: 'favorites#index'
      end
    end
  end
  
  # 管理者側
  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :posts, only: [:show, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end

end
