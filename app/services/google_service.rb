class GoogleService
  def initialize(location)
    @location = location
  end

  def city
    location_data(location)['formatted_address']
  end

  def lat_long
    location_data(location)['geometry']['location'].values.join(',')
  end

  private

  def conn
    Faraday.new(url: 'https://maps.googleapis.com/maps/api/geocode/json') do |faraday|
      faraday.params['key'] = ENV['GOOGLE_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end

  def location_data(location)
    response = conn.get do |request|
      request.params['address'] = location
    end
    @location_data ||= JSON.parse(response.body)['results'].first
  end

  private
  attr_reader :location
end
