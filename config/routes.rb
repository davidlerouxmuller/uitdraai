Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  post 'degrees/upload_logs' => 'degrees#upload_logs'

  resources :fields
  resources :probes
  resources :degrees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
