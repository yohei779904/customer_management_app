Rails.application.routes.draw do
  # pathオプションに空文字を与えることで、URLパスは/staffから/に変わり、/staff/loginから/loginに変わる。
  namespace :staff, path: '' do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    resource :session, only: [:create, :destroy]
    resource :account, except: [:new, :create, :destroy]
  end

  namespace :admin do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    resource :session, only: [:create, :destroy]
    resources :staff_members
  end

  namespace :customer do
    root 'top#index'
  end
end
