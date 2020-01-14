require 'rails_helper'

describe 'weather api' do
  it 'can register users' do
    post '/api/v1/users',
    params: {
              "email": "whatever@example.com",
              "password": "password",
              "password_confirmation": "password"
            }

    user_info = JSON.parse(response.body)

    expect(response).to have_http_status(201)
    expect(user_info['data']['attributes']['api_key'].length).to eq(26)
  end

  it 'can send error messages for bad registration' do
    post '/api/v1/users',
    params: {
              "email": "whatever@example.com",
              "password": "password",
              "password_confirmation": "passwor"
            }

    user_info = JSON.parse(response.body)

    expect(response).to have_http_status(400)
    expect(user_info['errors'].first['detail']).to eq("Password confirmation doesn't match Password")
  end
end
