Rails.application.routes.draw do
  namespace :api, as: '', :defaults => {:format => :json} do
    resources :time_slots, path: :timeslots
    resources :assignments
    resources :bookings
    resources :boats
  end
end
