Kgblogs::Application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letters" if Rails.env.development?
  
  devise_for :users
  
  resource :user, only: [:show]

  resources :posts
  resources :imports, except: [:edit, :update]

  get ':user_name' => 'posts#index'
  scope ':user_name', as: 'profile' do
    resource :user
    resources :posts, only: [:index, :show]
  end
  
  root to: 'public#welcome'
end
