FamilyHut::Application.routes.draw do

  resource :user_session
  resource :account, :controller => "users"
  resources :users

  resources :albums do
    resources :photos do
      collection do
        get 'new_ten'
        post 'create_ten'
        post 'update_title'
      end
      
      member do
        post 'create_comment'
      end
    end
  end

  match '/login' => 'user_sessions#new', :as => :login
  match '/logout' => 'user_sessions#destroy', :as => :logout
  match '/' => 'users#dashboard', :as => :dashboard
  match '/new_post' => 'users#new_post', :as => :new_post
  match '/delete_post/:id' => 'users#delete_post', :as => :delete_post
  
end
