Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :public do
    get 'search', to: 'searches#search'
  end

  namespace :admin do
    get 'search', to: 'searches#search'
  end

  devise_for :admins, skip: [:passwords], controllers: {
    sessions: 'admins/sessions'
  }

  scope module: :public do
    root to: "homes#top"
    get '/posts', to: 'posts#index', as: 'public_posts'
    get '/about', to: 'homes#about'
    get '/customers/check' => 'customers#check'
    delete '/customers/withdraw' => 'customers#withdraw'

    resources :customers, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
      collection do
        get 'check'
      end
      resources :groups, only: [:new, :show, :create, :edit, :update] do
        resources :group_customers, only: [:create, :destroy]
        resources :group_messages, only: [:create, :new]
      end
    end
      resources :posts, only: [:new, :show, :edit, :create, :destroy, :update] do
        resources :favorites, only: [:create, :destroy]
        resources :comments, only: [:create]
      end
    resources :groups, only: [:index]

  end

  resources :rooms, only: [:create, :index, :show] do
    resources :messages, only: [:create]
  end

  namespace :admins do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy]
    resources :admins, only: [:destroy]

    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
    patch "withdraw/:id" => "customers#withdraw", as: "withdraw"
    patch "comeback/:id" => "customers#comeback", as: "comeback"
  end
end
