Rails.application.routes.draw do

  namespace :public do
    get 'search/search'
  end
  namespace :admin do
    get 'search/search'
  end

  devise_for :customers, controllers: {
  registrations:  'customers/registrations',
  sessions: 'customers/sessions'
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


  devise_for :admins, controllers: {
  sessions: 'admins/sessions'
  }
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :admins, only: [:destroy]
  end
end

