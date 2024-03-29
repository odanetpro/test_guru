# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'tests#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout },
                     controllers: { sessions: 'users/sessions' }

  get 'feedback', to: 'feedbacks#new'
  post 'feedback', to: 'feedbacks#create'

  resources :tests, only: :index do
    resources :questions, shallow: true, only: :show

    member do
      post :start
    end
  end

  resources :passing_tests, only: %i[show update] do
    resources :gists, only: :create

    member do
      get :result
    end
  end

  resources :badges, only: %i[index show]
  resources :awards, only: :index

  namespace :admin do
    resources :badges
    resources :categories

    resources :tests do
      patch :update_inline, on: :member

      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end

    resources :gists, only: :index
  end
end
