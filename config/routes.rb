Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :public do
    get 'search/search'
  end
  namespace :admin do
    get 'search/search'
  end

  devise_for :admins, controllers: {
  sessions: 'admins/sessions'
  }

  scope module: :public do
    root to: "homes#top"
    get '/posts', to: 'posts#index', as: 'public_posts'
    get '/about', to: 'homes#about'
    resources :customers, only: [:index, :show, :edit, :update] do
      collection do
        get 'check'
      end
      resources :posts, only: [:new, :show, :edit, :create, :destroy, :update] do
        resource :favorite, only: [:create, :destroy]
        get "search", to: "searches#search"
      end
      resources :groups, only: [:new, :show, :create, :edit, :update]
    end
    resources :groups, only: [:index]
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy,]
    resources :admins, only: [:destroy]
  end
end