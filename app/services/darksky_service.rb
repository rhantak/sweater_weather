class DarkskyService
  def initialize(coordinates)
    @coordinates = coordinates
  end

  def current
    forecast_data['currently']
  end

  private

  attr_reader :coordinates

  def conn
    Faraday.new(url: "https://api.darksky.net/forecast/#{ENV['DARKSKY_KEY']}/#{coordinates}") do |faraday|
      faraday.params['exclude'] = 'minutely,flags'
      faraday.adapter Faraday.default_adapter
    end
  end

  def forecast_data
    response = conn.get
    @forecast_data ||= JSON.parse(response.body)
  end
end
