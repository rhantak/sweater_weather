class WeeklyForecast
  def initialize(weather)
    @days = weather['daily']['data'][1..7]
  end

  def weekly_data
    @days.map do |day|
      {
        "day": Time.at(day['time']).in_time_zone(day['timezone']).strftime("%A"),
        "weather": day['summary'],
        "precip_type": day['precipType'],
        "precip_chance": "#{(day['precipProbability']*100).round}%",
        "high": day['temperatureHigh'].round,
        "low": day['temperatureLow'].round
      }
    end
  end
end
