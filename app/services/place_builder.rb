class PlaceBuilder
  include PlaceCrawler

  def initialize params
    @city = params
  end

  def api_place_data
    PlaceCrawler.get_place(@city)
  end

  def place
    ApiPlaceDecorator.new(api_place_data).decorate
  end

  def build
    Place.create(place)
  end
end
