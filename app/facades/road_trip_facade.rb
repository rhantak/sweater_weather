class RoadTripFacade
  def initialize(location, target)
    @location = location
    @target = target
  end

  def id
  end

  def origin
    maps_data['routes'].first['legs'].first['start_address']
  end

  def destination
    maps_data['routes'].first['legs'].first['end_address']
  end

  def travel_time
    maps_data['routes'].first['legs'].first['duration']['text']
  end

  def arrival_forecast
    arrival_hour = darksky_data['hourly']['data'].find do |hour|
      hour['time'] > arrival_time
    end
    { "temperature": arrival_hour['temperature'].round,
      "summary": arrival_hour['summary'] }
  end

  private

  attr_reader :location, :target

  def maps_data
    @maps_data ||= GoogleService.new(location, target).route_data
  end

  def destination_coordinates
    maps_data['routes'].first['legs'].first['end_location'].values.join(',')
  end

  def darksky_data
    @darksky_data ||= DarkskyService.new(destination_coordinates).daily
  end

  def arrival_time
    start_time = darksky_data['currently']['time']
    duration = maps_data['routes'].first['legs'].first['duration']['value']
    start_time + duration
  end
end
