class AntipodeFacade
  def initialize(location)
    @location = location
  end

  def id
    1
  end

  def location_name
    google_antipode.city
  end

  def forecast
    AntipodeForecast.new(darksky_service.current)
  end

  def search_location
    google_service.city
  end

  private

  attr_reader :location

  def antipode_location
    @antipode_location ||= AmypodeService.new(google_service.lat_long).coordinates
  end

  def google_service
    @google_service ||= GoogleService.new(location)
  end

  def google_antipode
    @google_antipode ||= GoogleService.new(antipode_location)
  end

  def darksky_service
    @darksky_service ||= DarkskyService.new(antipode_location)
  end
end
