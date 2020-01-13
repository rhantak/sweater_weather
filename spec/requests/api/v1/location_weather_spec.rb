require 'rails_helper'

describe 'Weather API' do
  before(:each) do
    get '/api/v1/forecast?location=denver,co'
    @info = JSON.parse(response.body)
  end

  it 'sends the city name' do
    expect(response).to be_successful

    expect(@info['data']['attributes']['city']).to eq("Denver, CO, USA")
  end

  xit 'sends the current temperature' do

  end

  xit 'sends the current time and date' do

  end

  xit 'sends a string describing the current weather' do

  end

  xit 'sends a daily high and low' do

  end

  xit 'sends strings for day time and night time weather' do

  end

  xit "sends information for a 5 day forecast" do

  end
end
