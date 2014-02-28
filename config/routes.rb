Rathole::Application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letters" if Rails.env.development?
  
  devise_for :users, skip: [:registrations]
  devise_scope :user do
    resource :registration, only: [:new, :create], path: 'users', controller: 'devise/registrations', as: :user_registration
  end
  
  resource :user do
    get :events
    post :avatar
    resources :posts do 
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

  post '/posts/:post_id/comment', to: 'comments#create', as: 'create_comment'
  post '/posts/:post_id/comment/:id/destroy', to: 'comments#destroy', as: 'destroy_comment'

  post '/pictures/upload', to: 'pictures#upload', as: 'upload_picture'
  post '/pictures/:id/destroy', to: 'pictures#destroy', as: 'destroy_picture'

  get '/:user_name', to: 'public#profile'
  get '/:user_name/posts', to: 'public#posts'
  get '/:user_name/posts/:id', to: 'public#post'
  get '/:user_name/sections/:id', to: 'public#section'
  get '/tag/:tag', to: 'public#posts'

  # support for legacy public routes

  get '/public/:user_name', to: redirect('/%{user_name}')
  get '/public/:user_name/posts', to: redirect('/%{user_name}/posts')
  get '/public/:user_name/posts/:id', to: redirect('/%{user_name}/posts/%{id}')
  get '/public/:user_name/section/:id', to: redirect('/%{user_name}/sections/%{id}')
  get '/public/tag/:tag', to: redirect('/tag/%{tag}')

  root to: 'public#posts'
end
