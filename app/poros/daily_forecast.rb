class DailyForecast
  attr_reader :high, :low, :today, :tonight
  
  def initialize(weather)
    @high = weather['daily']['data'].first['temperatureHigh'].round
    @low = weather['daily']['data'].first['temperatureLow'].round
    @today = weather['daily']['data'].first['summary']
    @tonight = weather['hourly']['data'][20]['summary']
  end
end
