Kezz::Application.routes.draw do
  
  
  resources :poems

  root :to => 'pages#home'

  devise_for :users do  
    resources :libraries do
      resources :readings
    end
  end

  resources :users, :only => [:show]

  resources :paragraphs do
    collection do
      post :sort
    end
  end

  resources :sentences do
    collection do
      post :sort
    end
  end

  resources :phrases do
    collection do
      post :sort
    end
  end

  match '/check_order', :to => 'readings#check_order', :as => "check_order"

  match '/about', :to => 'pages#about', :as => "about"
  match '/contact', :to => 'pages#contact', :as => "contact"
end