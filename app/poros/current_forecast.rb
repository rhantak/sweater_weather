class CurrentForecast
  attr_reader :time, :date, :temp, :weather

  def initialize(current_weather)
    @time = Time.at(current_weather['time']).strftime("%I:%M%p")
    @date = Time.at(current_weather['time']).strftime("%m/%d")
    @temp = current_weather['temperature'].round
    @weather = current_weather['summary']
  end
end
