class WeeklyForecast
  attr_reader :first, :second, :third, :fourth, :fifth, :sixth, :seventh

  def initialize(weather)
    @days = [ weather['daily']['data'][1],
              weather['daily']['data'][2],
              weather['daily']['data'][3],
              weather['daily']['data'][4],
              weather['daily']['data'][5],
              weather['daily']['data'][6],
              weather['daily']['data'][7]]
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
