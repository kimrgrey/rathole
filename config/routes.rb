Kgblogs::Application.routes.draw do
  resources :posts
  resources :imports, except: [:edit, :update]
  
  root to: 'posts#index'
end
