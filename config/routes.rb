Rails.application.routes.draw do
  get '/score/list'
  get '/', to: 'main#home'
  get '/main/test'
  get '/score/list'
  get '/score/delete'
  post '/main/test'
  post '/main/result', to: 'main#check'
  post '/score/list'
  get '/score/edit'
  post 'score/check'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
