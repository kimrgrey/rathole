Kgblogs::Application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letters" if Rails.env.development?
  
  devise_for :users, skip: [:registrations]
  devise_scope :user do
    resource :registration, only: [:new, :create], path: 'users', controller: 'devise/registrations', as: :user_registration
  end
  
  resource :user do
    post :avatar
    resources :posts do 
      member do
        post :publish
        post :comment
      end
    end
    resources :imports, only: [:index, :new, :create]
    resources :sections, except: [:index, :show]
  end

  post '/pictures/upload', to: 'pictures#upload', as: 'upload_picture'
  post '/pictures/:id/destroy', to: 'pictures#destroy', as: 'destroy_picture'

  get '/public/:user_name', to: 'public#profile'
  get '/public/:user_name/posts', to: 'public#posts'
  get '/public/:user_name/posts/:id', to: 'public#post'
  get '/public/:user_name/section/:id', to: 'public#section'
  get '/public/tag/:tag', to: 'public#posts'

  root to: 'public#posts'
end
