require 'rails_helper'

describe 'google service' do
  it 'has keys' do
    WebMock.disable!

    service = GoogleService.new('denver,co', 'dallas,tx')
    route_data = service.route_data

    expect(service.city).to eq("Denver, CO, USA")
    expect(service.lat_long).to eq("39.7392358,-104.990251")
    expect(route_data['routes'].first['legs'].first['start_address']).to_not be_nil
    expect(route_data['routes'].first['legs'].first['end_address']).to_not be_nil
    expect(route_data['routes'].first['legs'].first['end_location']).to_not be_nil
    expect(route_data['routes'].first['legs'].first['duration']['text']).to_not be_nil
    expect(route_data['routes'].first['legs'].first['duration']['value']).to_not be_nil
  end
end
