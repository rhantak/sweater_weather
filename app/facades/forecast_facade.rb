class ForecastFacade
  attr_reader :location
  def initialize(location)
    @location = location
  end

  def coordinates
    google_service.lat_long
  end

  def id
  end

  def city
    google_service.city
  end

  def current
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
end
