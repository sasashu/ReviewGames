Rails.application.routes.draw do

  namespace :admin do
    resources :users, only:[:index, :show, :edit, :update]

    resources :tags, only:[:index, :create, :edit, :update, :destroy]

    resources :games

    resources :reviews, only:[:destroy]
    resources :comments, only:[:destroy]
  end

  scope module: :public do
    get 'users/my_page' =>'users#show', as: 'my_page'
    get 'users/infomation/edit' =>'users#edit', as: 'edit_infomation'
    patch 'users/infomation' =>'users#update', as: 'infomation'
    get 'users/confirm', as: 'confirm'
    patch 'users/withdraw', as: 'withdraw'

    resources :games, only:[:index, :show] do
      resources :reviews, only:[:new, :create, :destroy]
    end
    
    resources :reviews, only:[:new, :create, :destroy] do
      resources :comments, only:[:new, :create, :destroy]
    end

    get 'games/pc', as: 'pc'
    get 'games/ps', as: 'ps'
    get 'games/switch', as: 'switch'
    get 'games/portable', as: 'portable'
    get 'games/smartphone', as: 'smartphone'

    get '/'=> 'homes#top'
    get 'about'=> 'homes#about', as: 'about'
  end
  # 顧客用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
end
