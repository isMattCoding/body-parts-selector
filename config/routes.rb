Rails.application.routes.draw do
  root "bodies#index"

  resources :articles
  resources :bodies, only: %i[ index show new create ]
  post '/body_symptoms/:side', to: 'bodies#body_symptoms', as: 'body_symptoms'

end
