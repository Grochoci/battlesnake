Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



  # Shortcuts to controller methods for game engine
  post '/ping', to: 'api/v1/battlesnake_games#ping'
  post '/start', to: 'api/v1/battlesnake_games#start'
  post '/move', to: 'api/v1/battlesnake_games#move'
  post '/end', to: 'api/v1/battlesnake_games#end'

  # Api namespace broken down into different versions for future management
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :battlesnake_games do
        post 'ping'
        post 'start'
        post 'move'
        post 'end'
      end
    end
  end


end
