class AmypodeService
  def initialize(coordinates)
    @lat = coordinates.split(',')[0]
    @long = coordinates.split(',')[1]
  end

  def coordinates
    antipode_data['data']['attributes'].values.join(',')
  end

  private

  attr_reader :lat, :long

  def conn
    Faraday.new(url: 'http://amypode.herokuapp.com/api/v1/') do |faraday|
      faraday.headers['api_key'] = ENV['AMYPODE_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end

  def antipode_data
    response = conn.get('/antipodes') do |request|
      request.params['lat'] = lat
      request.params['long'] = long
    end
    @antipode_data ||= JSON.parse(response.body)
  end
end
