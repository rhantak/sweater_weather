class AntipodeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :location_name, :forecast, :search_location
end
