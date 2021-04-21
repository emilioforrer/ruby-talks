require 'test_helper'

class Api::V1::PokedexesControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    @token = Doorkeeper::AccessToken.create(resource_owner_id: user.id).token
    @pokemon = create(:pokemon)
  end

  test 'should add pokemon to user pokedex' do
    post add_pokemon_api_v1_pokemon_pokedexes_url(@pokemon),
         headers: { 'Authorization': "Bearer #{@token}" }
    assert_response :success
  end
end
