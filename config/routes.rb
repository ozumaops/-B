Rails.application.routes.draw do
  get 'posts/index'

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  # ログイン機能
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    collection {post :import}
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
      get 'attendances/edit_one_month_request'
      patch 'attendances/update_month_request'
      # 出勤社員 
      get 'list_of_employees'
    end
    resources :attendances do
      get 'edit_overwork_reqest'
      get 'edit_day_reqest'
    end
  end
end
