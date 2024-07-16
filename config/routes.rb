Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # ユーザー側
  devise_for :users, controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  

  scope module: :public do
    root 'homes#top'

    get 'about' => 'homes#about'
    get 'users/mypage' => 'users#mypage', as: 'mypage'
    devise_scope :user do
      post 'users/guest_sign_in', to: 'sessions#guest_sign_in', as: 'users_guest_sign_in'
    end
    resources :users, only: [:show, :edit, :update, :destroy] do
      member do
        get 'favorites', to: 'favorites#index'
      end
      resource :relationship, only: [:create, :destroy]
        get 'followers' => 'relationships#followers', as: 'followers'
        get 'followeds' => 'relationships#followeds', as: 'followeds'
    end
    resources :posts do
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end

  # 管理者側
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :posts, only: [:show, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :update]
  end

end
