require "test_helper"

class Api::V1::PokemonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    @token = Doorkeeper::AccessToken.create(resource_owner_id: user.id).token
  end

  test 'unauthorize index pokemons request' do
    get api_v1_pokemons_url
    assert_response :unauthorized
  end

  test 'list all pokemons' do
    get api_v1_pokemons_url,
        headers: { 'HTTP_AUTHORIZATION': "Bearer #{@token}" }
    assert_response :success
  end
end
