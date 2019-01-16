Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "static_pages#home"

    devise_for :users
    resources :users, only: [:index, :show, :destroy]
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
    resources :likes, only: [:create, :destroy]
  end
end
