require 'rails_helper'

describe 'antipode forecast facade' do
  before(:each) do
    hongkong_geocode = File.read('spec/fixtures/hongkong_geocode_data.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?key=#{ENV['GOOGLE_KEY']}&address=hongkong").
      to_return(status: 200, body: hongkong_geocode)

    hongkong_antipode = File.read('spec/fixtures/hongkong_amypode_data.json')
    stub_request(:get, 'http://amypode.herokuapp.com/antipodes?lat=22.3193039&long=114.1693611').
      to_return(status: 200, body: hongkong_antipode)

    antipode_geocode = File.read('spec/fixtures/antipode_hongkong_geocode_data.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?key=#{ENV['GOOGLE_KEY']}&address=-22.3193039,-65.8306389").
      to_return(status: 200, body: antipode_geocode)

    antipode_weather = File.read('spec/fixtures/antipode_hongkong_weather_data.json')
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_KEY']}/-22.3193039,-65.8306389?exclude=minutely,flags").
      to_return(status: 200, body: antipode_weather)

    @facade = AntipodeFacade.new('hongkong')
  end

  it 'can send a city name' do
    expect(@facade.location_name).to eq("RP69, Jujuy, Argentina")
  end

  it 'can send original search city' do
    expect(@facade.search_location).to eq("Hong Kong")
  end

  it 'can send weather data' do
    expect(@facade.forecast.summary).to eq("Overcast")
    expect(@facade.forecast.current_temperature).to eq(60)
  end
end
