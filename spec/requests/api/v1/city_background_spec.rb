require 'rails_helper'

describe 'weather api' do
  it 'can send an image of a city' do
    json_response = File.read('spec/fixtures/denver_unsplash_data.json')
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['UNSPLASH_KEY']}&per_page=1&query=denver,co").
      to_return(status: 200, body: json_response)

    get '/api/v1/backgrounds?location=denver,co'

    image_info = JSON.parse(response.body)

    expect(response).to be_successful

    expect(image_info['data']['attributes']['image_address']).to_not be_nil
    expect(image_info['data']['attributes']['image_address']).to_not be_empty
  end
end
