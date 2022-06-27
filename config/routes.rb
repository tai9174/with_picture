Rails.application.routes.draw do
  get 'favorites/index'
  get 'sessions/new'
  resources :favorites, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new,:create,:show,:edit,:update]
  resources :pictures do
    collection do
      post :confirm
    end
    get :favorites, on: :collection
  end
  
  scope "(:locale)", locale: /en|ja/ do
    resources :books
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
