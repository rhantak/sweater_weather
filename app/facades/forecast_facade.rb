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
    DailyForecast.new(darksky_service.daily)
  end

  def hourly
    HourlyForecast.new(darksky_service.hourly).hourly_data
  end

  def weekly
    WeeklyForecast.new(darksky_service.daily).weekly_data
  end

  private

  def google_service
    @google_service ||= GoogleService.new(location)
  end

  def darksky_service
    @darksky_service ||= DarkskyService.new(google_service.lat_long)
  end
end
