Rails.application.routes.draw do
  resources :departures, only: [:index]

  resources :schedule_import, only: [:index]

  root to: 'departures#index'
end
