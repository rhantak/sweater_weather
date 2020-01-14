class HourlyForecast
  def initialize(hourly_weather)
    @hours = hourly_weather
  end

  def hourly_data
    @hours.map do |hour|
      {
        "time": Time.at(hour['time']).in_time_zone(hour['timezone']).strftime("%I%p"),
        "temp": hour['temperature'].round
      }
    end
  end
end
