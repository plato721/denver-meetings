Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :meetings, only:[:index, :show]
  
  delete 'logout', to: 'sessions#destroy', as: "logout"
  get "auth/github", as: "login"
  get "auth/github/callback", to: "sessions#create"

  namespace :mobile do
    resources :search, only:[:new, :create, :index]
    resources :meetings, only:[:index, :show]
  end

  namespace :admin do
    root to: "admin#index"
    resources :meetings, only:[:index, :edit]
  end

  get '403', to: 'error#unauthorized', as: "unauthorized"
end
