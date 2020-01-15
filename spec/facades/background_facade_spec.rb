require 'rails_helper'

describe 'background facade' do
  it 'sends an image address' do
    json_response = File.read('spec/fixtures/denver_unsplash_data.json')
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['UNSPLASH_KEY']}&per_page=1&query=denver,co").
    to_return(status: 200, body: json_response)
    facade = BackgroundFacade.new('denver,co')

    expect(facade.image_address).to_not be_nil
  end
end
