Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  devise_for :users

  resources :users do
    resources :tasks
  end

  resources :tasks do
    resources :comments
  end

  resources :attachments

end