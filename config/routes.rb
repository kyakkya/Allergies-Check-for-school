Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
    end
    
    resources :attendances, only: [:edit, :update] do
     member do  
       get 'lunch_check'
       patch 'update_lunch_check'
     end   
     collection do
        get 'lunch_check_info'
        patch 'update_lunch_check_info'   
     end #collection do end
    end #resouces do end
  end #user resouces do end 
end
#draw do end