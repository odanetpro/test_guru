Rails.application.routes.draw do
  get 'users/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :tests do
    resources :questions, shallow: true, except: :index

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
