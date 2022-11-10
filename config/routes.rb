Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :tests do
    resources :questions, shallow: true, only: %i[show new edit create update destroy]

    member do
      post :start
    end
  end

  resources :passing_tests, only: %i[show update] do
    member do
      get :result
    end
  end
end
