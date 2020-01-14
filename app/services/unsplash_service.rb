class UnsplashService
  def initialize(location)
    @location = location
  end

  def image_address
    image_data['results'].first['urls']['full']
  end

  private

  attr_reader :location

  def conn
    Faraday.new(url: 'https://api.unsplash.com') do |faraday|
      faraday.params['client_id'] = ENV['UNSPLASH_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end

  def image_data
    response = conn.get('search/photos') do |request|
      request.params['query'] = location
      request.params['per_page'] = 1
    end
    @image_data ||= JSON.parse(response.body)
  end
end
