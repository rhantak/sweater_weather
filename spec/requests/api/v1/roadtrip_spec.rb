require 'rails_helper'

describe 'weather api' do
  it "can send roadtrip information" do
    WebMock.disable!

    user = User.create( email: 'whatever@example.com',
                            password: 'password',
                            password_confirmation: 'password')

    post '/api/v1/road_trip',
    params: {
              "origin": "Denver,CO",
              "destination": "Dallas,TX",
              "api_key": user.api_key
            }

    info = JSON.parse(response.body)

    expect(response).to be_successful

    expect(info['data']['attributes']['origin']).to eq("Denver, CO, USA")
    expect(info['data']['attributes']['destination']).to eq("Dallas, TX, USA")
    expect(info['data']['attributes']['travel_time']).to eq("12 hours 7 mins")
    expect(info['data']['attributes']['arrival_forecast']['temperature'].class).to eq(Integer)
    expect(info['data']['attributes']['arrival_forecast']['summary'].class).to eq(String)
  end

  it 'sends an error for invalid api key' do
    WebMock.disable!

    user = User.create( email: 'whatever@example.com',
                            password: 'password',
                            password_confirmation: 'password')

    post '/api/v1/road_trip',
    params: {
              "origin": "Denver,CO",
              "destination": "Dallas,TX",
              "api_key": "idknotarealkey"
            }

    info = JSON.parse(response.body)
    
    expect(info['errors'].first['detail']).to eq("Invalid API Key")
  end
end
