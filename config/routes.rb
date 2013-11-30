Kgblogs::Application.routes.draw do
  devise_for :users
  
  mount LetterOpenerWeb::Engine, at: "/letters" if Rails.env.development?

  resources :posts
  resources :imports, except: [:edit, :update]
  
  root to: 'posts#index'
end
