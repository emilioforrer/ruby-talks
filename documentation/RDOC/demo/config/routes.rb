Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  namespace :api do
    namespace :v1 do
      resources :pokemons, only: %i[index show] do
        collection do
          get :captured
        end
        resources :pokedexes, only: [] do
          collection do
            post :add_pokemon
            delete :remove_pokemon
          end
        end
      end
      resources :users, only: [:me] do
        collection do
          get :me
        end
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
