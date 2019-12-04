Rails.application.routes.draw do
  devise_for :users, path_names: {
      sign_in: 'login', password: 'password',
      registration: 'register', edit: '/admin/edit-account',
      destroy: '/admin/users'
  }, :controllers => { :registrations => "registrations", :sessions => "sessions"}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#main'

  ##########################################
  ### Admin panel
  get 'admin' => 'panels#dashboard'
  get '/admin/dashboard' => 'panels#dashboard', as: :dashboard
  get '/admin/settings' => 'panels#settings', as: :adminsettings
  get '/admin/sub-tabs' => 'panels#sub_tabs', as: :tabs
  get '/admin/help' => 'panels#help', as: :help
  get '/admin/events' => 'panels#events', as: :events

  get '/admin/sub-tabs/:id' => 'sub_tabs#edit', as: :edit_sub_tab
  post '/admin/sub-tabs/:id' => 'sub_tabs#edit', as: :post_edit_sub_tab
  patch '/admin/sub-tabs/:id' => 'sub_tabs#update', as: :update_sub_tab
  post '/admin/sub-tabs' => 'sub_tabs#create'
  post '/admin/sub-tabs' => 'sub_tabs#new'
  delete '/admin/sub-tabs' => 'sub_tabs#destroy'
  delete '/admin/users' => 'users#destroy'
  ### Only Admin
  get '/admin/users' => 'panels#users', as: :users # Privileges done
  get '/admin/tokens' => 'panels#tokens', as: :tokens
  get '/admin/users/token' => 'panels#generate_token', as: :generate_token
  post '/admin/users/suspend' => 'users#suspend'
  post '/admin/users/activate' => 'users#activate'
  post '/admin/users/delete' => 'users#delete', as: :delete_user
  ##########################################
  get 'test' => 'pages#test'

  as :user do
    get 'login' => 'devise/sessions#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
    get 'password' => 'devise/passwords#new'
    get 'register' => 'registrations#new'
    get '/admin/edit-account' => 'panels#edit_account', as: :edit_current_user
    get '/admin/user/changeImg' => 'panels#change_background_image'
    get '/admin/user/changeColor' => 'panels#change_background_color'
  end

  get ':main_tab_id/:id' => 'sub_tabs#show', as: :show_sub_tab

  resources :main_tabs, :path => ''
  resources :main_tabs, :path => '', :only => [] do
    resources :sub_tabs, :path => '', :except => [:create, :new, :destroy, :edit, :update]
  end
end