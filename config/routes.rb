Rails.application.routes.draw do

  delete 'logout', to: 'sessions#destroy', as: "logout"
  get "auth/github", as: "login"
  get "auth/github/callback", to: "sessions#create"


  namespace :admin do
    root to: "meetings#index"
  end

  get '403', to: 'error#unauthorized', as: "unauthorized"
end
