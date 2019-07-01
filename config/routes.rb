Rails.application.routes.draw do
  mount MagicLamp::Genie, at: "/magic_lamp" if defined?(MagicLamp)

  root to: 'welcome#index'
  get "faq", to: "welcome#faq"
  get "about", to: "welcome#about"
  
  resources :meetings, only:[:index, :show]
  
  get "login", to: "sessions#new", as: "login"
  post "login", to: "sessions#create"
  delete 'logout', to: 'sessions#destroy', as: "logout"

  namespace :mobile do
    resources :search, only:[:new, :create, :index] do
      collection do
        get 'results', to: "search#new"
        get 'here-and-now', to: "search#here_and_now"
        get 'get-new-options', to: "search#get_new_options"
        post 'free_search', to: "search#free_search"
      end
    end

    # are these used?
    get "search/create", to: "search#create"
    resources :meetings, only:[:index, :show]
    ####
  end

namespace :admin do
    root to: "dashboards#index", as: "dashboard"
    resources :meetings, only:[:index, :edit, :update]
    resources :users, only:[:index]
  end

  get '403', to: 'error#unauthorized', as: "unauthorized"

end
