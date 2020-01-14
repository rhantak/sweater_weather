class DailyForecast
  attr_reader :high, :low, :today, :tonight

  def initialize(weather)
    @high = weather['daily']['data'].first['temperatureHigh'].round
    @low = weather['daily']['data'].first['temperatureLow'].round
    @today = weather['daily']['data'].first['summary']
    @tonight = night_summary(weather)
  end

  def night_summary(weather)
    current_hour = Time.at(weather['hourly']['data'].first['time']).in_time_zone(weather['timezone']).strftime("%k").to_i
    if current_hour < 20
      weather['hourly']['data'][20-current_hour]['summary']
    else
      weather['hourly']['data'][current_hour]['summary']
    end
  end
end
