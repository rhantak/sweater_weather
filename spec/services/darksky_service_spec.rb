require 'rails_helper'

describe 'darksky service' do
  it 'has keys' do
    WebMock.disable!

    service = DarkskyService.new("39.7411598,-104.9879112")
    response = service.daily

    expect(response['currently']['time']).to_not be_nil
    expect(response['currently']['temperature']).to_not be_nil
    expect(response['currently']['summary']).to_not be_nil
    expect(response['currently']['apparentTemperature']).to_not be_nil
    expect(response['currently']['humidity']).to_not be_nil
    expect(response['currently']['visibility']).to_not be_nil
    expect(response['currently']['uvIndex']).to_not be_nil

    expect(response['daily']['data'].length).to eq(8)
    expect(response['daily']['data'].first['temperatureHigh']).to_not be_nil
    expect(response['daily']['data'].first['temperatureLow']).to_not be_nil
    expect(response['daily']['data'].first['summary']).to_not be_nil
    expect(response['daily']['data'].first['precipType']).to_not be_nil
    expect(response['daily']['data'].first['precipProbability']).to_not be_nil

    expect(response['hourly']['data'].length).to eq(49)
    expect(response['hourly']['data'].first['time']).to_not be_nil
    expect(response['hourly']['data'].first['summary']).to_not be_nil
    expect(response['hourly']['data'].first['temperature']).to_not be_nil
  end
end
