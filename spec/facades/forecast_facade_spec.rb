require 'rails_helper'

describe 'forecast facade' do
  it 'city' do
    facade = ForecastFacade.new('denver,co')
    expect(facade.city).to eq('Denver, CO, USA')
  end

  it 'coordinates' do
    facade = ForecastFacade.new('denver,co')
    expect(facade.coordinates).to eq({"lat"=>39.7392358, "lng"=>-104.990251})
  end
end
