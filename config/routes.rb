Rails.application.routes.draw do
  resources :time_slots
  resources :assignments
  resources :bookings
  resources :boats
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
