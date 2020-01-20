Rails.application.routes.draw do
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#  resources :calendar
#  resources :calendar_dates
  resources :routes
  resources :shapes, only: [:show]
  resources :stops
  resources :stop_times, only: [:show]
  resources :trips

  root 'welcome#index'
end
