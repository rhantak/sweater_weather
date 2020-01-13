require 'rails_helper'

describe 'forecast facade' do
  before(:each) do
    json_response = File.read('spec/fixtures/denver_geocode_data.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?key=#{ENV['GOOGLE_KEY']}&address=denver,co").
      to_return(status: 200, body: json_response)

    darksky_response = File.read('spec/fixtures/denver_darksky_data.json')
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_KEY']}/39.7392358,-104.990251?exclude=minutely,flags").
      to_return(status: 200, body: darksky_response)

    @facade = ForecastFacade.new('denver,co')
  end

  it 'city' do
    expect(@facade.city).to eq('Denver, CO, USA')
  end

  it 'current' do
    expect(@facade.current.time).to eq("12:10AM")
    expect(@facade.current.date).to eq("01/13")
    expect(@facade.current.temp).to eq(26)
    expect(@facade.current.weather).to eq("Clear")
  end

  it 'daily' do
    expect(@facade.daily.high).to eq(44)
    expect(@facade.daily.low).to eq(23)
    expect(@facade.daily.today).to eq("Clear throughout the day.")
    expect(@facade.daily.tonight).to eq("Clear")
  end
end
