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

  it 'sends current feels like temperature' do
    expect(@info['data']['attributes']['current']['feels_like']).to eq(26)
  end

  it "sends current humidity" do
    expect(@info['data']['attributes']['current']['humidity']).to eq("44%")
  end

  it "sends current visibility" do
    expect(@info['data']['attributes']['current']['visibility']).to eq("10.0 miles")
  end

  it "sends current uv index" do
    expect(@info['data']['attributes']['current']['uv_index']).to eq(0)
  end

  it 'sends a daily high and low' do
    expect(@info['data']['attributes']['daily']['high']).to eq(44)
    expect(@info['data']['attributes']['daily']['low']).to eq(23)
  end

  it 'sends strings for day time and night time weather' do
    expect(@info['data']['attributes']['daily']['today']).to eq("Clear throughout the day.")
    expect(@info['data']['attributes']['daily']['tonight']).to eq("Clear")
  end

  it "sends information for a 5 day forecast" do
    expect(@info['data']['attributes']['weekly'].count).to eq(7)

    expect(@info['data']['attributes']['weekly'][0]['day']).to eq("Tuesday")
    expect(@info['data']['attributes']['weekly'][1]['day']).to eq("Wednesday")
    expect(@info['data']['attributes']['weekly'][2]['day']).to eq("Thursday")
    expect(@info['data']['attributes']['weekly'][3]['day']).to eq("Friday")

    expect(@info['data']['attributes']['weekly'][0]['weather']).to eq("Clear throughout the day.")
    expect(@info['data']['attributes']['weekly'][1]['weather']).to eq("Clear throughout the day.")
    expect(@info['data']['attributes']['weekly'][2]['weather']).to eq("Mostly cloudy throughout the day.")
    expect(@info['data']['attributes']['weekly'][3]['weather']).to eq("Clear throughout the day.")

    expect(@info['data']['attributes']['weekly'][0]['precip_type']).to eq("snow")
    expect(@info['data']['attributes']['weekly'][1]['precip_type']).to eq("snow")
    expect(@info['data']['attributes']['weekly'][2]['precip_type']).to eq(nil)
    expect(@info['data']['attributes']['weekly'][3]['precip_type']).to eq("snow")

    expect(@info['data']['attributes']['weekly'][0]['precip_chance']).to eq("1%")
    expect(@info['data']['attributes']['weekly'][1]['precip_chance']).to eq("2%")
    expect(@info['data']['attributes']['weekly'][2]['precip_chance']).to eq("1%")
    expect(@info['data']['attributes']['weekly'][3]['precip_chance']).to eq("2%")

    expect(@info['data']['attributes']['weekly'][0]['high']).to eq(51)
    expect(@info['data']['attributes']['weekly'][1]['high']).to eq(49)
    expect(@info['data']['attributes']['weekly'][2]['high']).to eq(51)
    expect(@info['data']['attributes']['weekly'][3]['high']).to eq(49)

    expect(@info['data']['attributes']['weekly'][0]['low']).to eq(24)
    expect(@info['data']['attributes']['weekly'][1]['low']).to eq(24)
    expect(@info['data']['attributes']['weekly'][2]['low']).to eq(30)
    expect(@info['data']['attributes']['weekly'][3]['low']).to eq(22)
  end

  it "sends hourly temperature information" do
    expect(@info['data']['attributes']['hourly'].length).to eq(24)

    expect(@info['data']['attributes']['hourly'][0]['time']).to eq("12AM")
    expect(@info['data']['attributes']['hourly'][1]['time']).to eq("01AM")
    expect(@info['data']['attributes']['hourly'][2]['time']).to eq("02AM")
    expect(@info['data']['attributes']['hourly'][3]['time']).to eq("03AM")

    expect(@info['data']['attributes']['hourly'][0]['temp']).to eq(26)
    expect(@info['data']['attributes']['hourly'][1]['temp']).to eq(25)
    expect(@info['data']['attributes']['hourly'][2]['temp']).to eq(24)
    expect(@info['data']['attributes']['hourly'][3]['temp']).to eq(24)
  end
end
