class AntipodeForecast
  attr_reader :summary, :current_temp

  def initialize(antipode_weather)
    @summary = antipode_weather['summary']
    @current_temperature = antipode_weather['temperature'].round
  end
end
