class CurrentForecast
  attr_reader :time, :date, :temp, :weather

  def initialize(current_weather)
    @time = Time.at(current_weather['time']).in_time_zone(current_weather['timezone']).strftime("%I:%M%p")
    @date = Time.at(current_weather['time']).in_time_zone(current_weather['timezone']).strftime("%m/%d")
    @temp = current_weather['temperature'].round
    @weather = current_weather['summary']
    @feels_like = current_weather['apparentTemperature'].round
    @humidity = "#{(current_weather['humidity']*100).round}%"
    @visibility = "#{current_weather['visibility'].round(2)} miles"
    @uv_index = current_weather['uvIndex']
  end
end
