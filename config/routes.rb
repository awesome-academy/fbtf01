Rails.application.routes.draw do
  get "sessions/new"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "static_pages#home"

    get "/register", to: "users#new"
    post "/register", to: "users#create"

    get "/sign_in", to: "sessions#new"
    post "/sign_in", to: "sessions#create"
    delete "/sign_out", to: "sessions#destroy"

    resources :users
  end
end
