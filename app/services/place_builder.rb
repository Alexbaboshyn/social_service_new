class PlaceBuilder
  include PlaceCrawler

  def initialize params
    @city = params
  end

  def place
    ApiPlaceDecorator.new(get_place).decorate
  end

  def build    
    Place.create(place)
  end
end
