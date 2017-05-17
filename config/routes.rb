Rails.application.routes.draw do
  resources :posts, except:[:index] do
    resources :comments, only: [:create, :destroy]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:show, :new, :create]

  root to: 'posts#index'
end
