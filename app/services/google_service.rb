class GoogleService
  def initialize(location, destination = nil)
    @location = location
    @destination = destination
  end

  def city
    location_data(location)['formatted_address']
  end

  def lat_long
    location_data(location)['geometry']['location'].values.join(',')
  end

  def route_data
    response = conn.get("/maps/api/directions/json") do |request|
      request.params['origin'] = location
      request.params['destination'] = destination
    end
    @route_data ||= JSON.parse(response.body)
  end

  private

  attr_reader :location, :destination

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
end
