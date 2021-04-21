require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    @token = Doorkeeper::AccessToken.create(resource_owner_id: user.id).token
  end

  test 'unauthorize me on request' do
    get me_api_v1_users_url
    assert_response :unauthorized
  end

  test 'get user information' do
    get me_api_v1_users_url,
        headers: { 'HTTP_AUTHORIZATION': "Bearer #{@token}" }
    assert_response :success
  end
end