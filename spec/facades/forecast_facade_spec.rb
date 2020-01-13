require 'rails_helper'

describe 'forecast facade' do
  before(:each) do
    json_response = File.read('spec/fixtures/denver_geocode_data.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?key=#{ENV['GOOGLE_KEY']}&address=denver,co").
      to_return(status: 200, body: json_response)
  end

  it 'city' do
    facade = ForecastFacade.new('denver,co')
    expect(facade.city).to eq('Denver, CO, USA')
  end
end
