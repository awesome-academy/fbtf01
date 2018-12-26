Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "static_pages#home"

    get "/register", to: "users#new"
    post "/register", to: "users#create"

    resources :users
  end
end
