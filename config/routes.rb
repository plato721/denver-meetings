Rails.application.routes.draw do
  namespace :admin do
    root to: "meetings#index"
    get "auth/github", as: "login"
    get "auth/github/callback", to: "sessions#create"
  end
end
