Rails.application.routes.draw do

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :subs, except: :destroy do
    resources :posts do
      resources :comments, only: :new
    end
  end

  resources :comments, only: [:create, :show]
end
