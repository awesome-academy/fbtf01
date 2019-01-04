Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "static_pages#home"

    get "/register", to: "users#new"
    post "/register", to: "users#create"

    get "/users/:id/edit_password", action: :edit_password,
      controller: "users", as: "edit_password"

    get "/sign_in", to: "sessions#new"
    post "/sign_in", to: "sessions#create"
    delete "/sign_out", to: "sessions#destroy"

    resources :users do
      member do
        patch "update_password", to: "users#update_password"
      end
    end
    resources :password_resets, except: [:index, :show, :destroy]
    resources :locations
    resources :tours, only: [:index, :show]
    resources :bookings do
      member do
        patch "approve"
        patch "cancel"
      end
    end
    post "/total_price", to: "bookings#total_price", as: "total_price"

    resources :charges
    resources :reviews
  end
end
