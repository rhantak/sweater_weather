class ForecastFacade
  attr_reader :location
  def initialize(location)
    @location = location
  end

  def id
  end

  def city
    google_service.city
  end

  def current
    CurrentForecast.new(darksky_service.current)
  end

  def daily
  end

  def hourly
  end

  def weekly
  end

  private

  def google_service
    @google_service ||= GoogleService.new(location)
  end

  def darksky_service
    @darksky_service ||= DarkskyService.new(google_service.lat_long)
  end
end
