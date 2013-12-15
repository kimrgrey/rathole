Kgblogs::Application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letters" if Rails.env.development?
  
  devise_for :users, skip: [:registrations]
  devise_scope :user do
    resource :registration, only: [:new, :create], path: 'users', controller: 'devise/registrations', as: :user_registration
  end
  
  resource :user

  resources :posts
  resources :imports, except: [:edit, :update]

  get ':user_name' => 'posts#index'
  scope ':user_name', as: 'profile' do
    resource :user, only: [:show]
    resources :posts, only: [:index, :show]
  end

  get 'tag/:tag', to: 'public#welcome', as: 'tag'
  root to: 'public#welcome'
end
