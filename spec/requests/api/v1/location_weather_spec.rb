require 'rails_helper'

describe 'Weather API' do


  before(:each) do
    json_response = File.read('spec/fixtures/denver_geocode_data.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?key=#{ENV['GOOGLE_KEY']}&address=denver,co").
      to_return(status: 200, body: json_response)

    darksky_response = File.read('spec/fixtures/denver_darksky_data.json')
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_KEY']}/39.7392358,-104.990251?exclude=minutely,flags").
    to_return(status: 200, body: darksky_response)

    get '/api/v1/forecast?location=denver,co'
    @info = JSON.parse(response.body)
  end

  it 'sends the city name' do
    expect(response).to be_successful

    expect(@info['data']['attributes']['city']).to eq("Denver, CO, USA")
  end

  it 'sends the current temperature' do
    expect(@info['data']['attributes']['current']['temp']).to eq(26)
  end

  it 'sends the current time and date' do
    expect(@info['data']['attributes']['current']['time']).to eq("12:10AM")
    expect(@info['data']['attributes']['current']['date']).to eq("01/13")
  end

  it 'sends a string describing the current weather' do
    expect(@info['data']['attributes']['current']['weather']).to eq("Clear")
  end

  it 'sends a daily high and low' do
    expect(@info['data']['attributes']['daily']['high']).to eq(44)
    expect(@info['data']['attributes']['daily']['low']).to eq(23)
  end

  it 'sends strings for day time and night time weather' do
    expect(@info['data']['attributes']['daily']['today']).to eq("Clear throughout the day.")
    expect(@info['data']['attributes']['daily']['tonight']).to eq("Clear")
  end

  xit "sends information for a 5 day forecast" do

  end
end
