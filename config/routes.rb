Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get 'homes/top' => 'homes#top'
  get 'homes/mypage' => 'homes#mypage'

  # resources :users, only: [:show, :index, :destroy]
  resources :users

  resources :conversations, only: [:create, :show]
end

