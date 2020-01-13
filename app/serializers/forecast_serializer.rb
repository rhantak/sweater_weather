class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :city, :current, :daily, :hourly, :weekly
end
