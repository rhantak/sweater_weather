require 'rails_helper'

describe 'weather api' do
  it 'can log in a user' do
    user = User.create( email: 'whatever@example.com',
                        password: 'password',
                        password_confirmation: 'password')

    post '/api/v1/sessions',
    params: {
              "email": "whatever@example.com",
              "password": "password"
            }

    user_info = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(user_info['data']['attributes']['api_key']).to eq(user.api_key)
  end

  it 'sends an error message for bad credentials' do
    post '/api/v1/sessions',
    params: {
              "email": "whatever@example.com",
              "password": "password"
            }

    user_info = JSON.parse(response.body)

    expect(response).to have_http_status(400)

    expect(user_info['errors'].first['detail']).to eq("Bad Credentials")
  end
end
