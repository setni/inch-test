Rails.application.routes.draw do

    root 'pages#home'
    post 'update' => 'pages#update'
    get 'result' => 'pages#result'
end
