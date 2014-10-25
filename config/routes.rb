Rathole::Application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letters" if Rails.env.development?
  
  devise_for :users, skip: [:registrations], controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    resource :registration, only: [:new, :create], path: 'users', controller: 'registrations', as: :user_registration
  end
  
  resource :user do
    post :avatar
    get :events, to: 'events#index'
    resources :posts, except: [:index, :show] do 
      member do
        post :publish
      end
    end
    resources :imports, only: [:index, :new, :create]
    resources :sections, except: [:index, :show]
    
    post '/subscriptions', to: 'subscriptions#subscribe'
    delete '/subscriptions', to: 'subscriptions#unsubscribe'
  end

  authenticated :user, -> (user) { user.admin? } do
    mount Delayed::Web::Engine, at: '/jobs'
    
    namespace :admin do 
      resources :users, only: [:show, :destroy]
      resources :posts, only: [:show, :destroy] do
        member do 
          post :hide_from_main
          post :show_on_main
        end
      end
      
      get '/jobs', to: redirect('/jobs'), as: 'jobs'
      get '/statistics', to: 'dashboard#statistics'
      
      root to: 'dashboard#home'
    end
  end

  resources :bugs, except: [:new, :edit, :update, :destroy] do 
    member do 
      post :fix
      post :reject
    end
  end

  resources :comments, only: [:index, :create, :update, :destroy]

  namespace :api do
    namespace :v1 do
      get '/sync', to: 'sync#sync'
      get '/post/:id', to: 'sync#post'

      post '/post/:id/claim', to: 'sync#claim'
    end
  end
  
  get '/overview', to: 'public#overview', as: 'overview'

  post '/pictures/upload', to: 'pictures#upload', as: 'upload_picture'
  post '/pictures/:id/destroy', to: 'pictures#destroy', as: 'destroy_picture'

  get '/help', to: 'public#help'
  post '/claim', to: 'public#claim'

  get '/posts', to: 'posts#index'
  get '/user/posts/:id', to: 'posts#show'
  get '/:user_name', to: 'users#show'
  get '/:user_name/posts', to: 'posts#index', :as => 'user_posts_index'
  get '/:user_name/posts/:id', to: 'posts#show'
  get '/:user_name/sections/:id', to: 'public#section'
  get '/tag/:tag', to: 'posts#index'

  # support for legacy public routes

  get '/public/:user_name', to: redirect('/%{user_name}')
  get '/public/:user_name/posts', to: redirect('/%{user_name}/posts')
  get '/public/:user_name/posts/:id', to: redirect('/%{user_name}/posts/%{id}')
  get '/public/:user_name/section/:id', to: redirect('/%{user_name}/sections/%{id}')
  get '/public/tag/:tag', to: redirect('/tag/%{tag}')

  root to: 'public#welcome'
end
