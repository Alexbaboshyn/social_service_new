class PlaceBuilder
  def initialize params
    @city = params
  end

  def data
    @data ||= URI("https://restcountries.eu/rest/v2/capital/#{ @city }").read
  end

  def place
    JSON.parse(data, symbolize_names: true)
  end

  def build
    Place.create(ApiPlaceDecorator.new(place).decorate)
  end
end
