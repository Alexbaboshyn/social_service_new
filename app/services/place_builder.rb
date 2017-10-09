class PlaceBuilder
  require 'open-uri'

  def initialize params
    @city = params
  end

  def data
    URI("https://restcountries.eu/rest/v2/capital/#{ @city }").read
  end

  def place
    JSON.parse(data, symbolize_names: true)
  end

  def build
    Place.create(name: place[0][:name],
                 city: place[0][:capital],
                  lat: place[0][:latlng][0],
                  lng: place[0][:latlng][1],
       overall_rating: rating,
                 tags: tags)
  end

  def rating
    place[0][:languages][0][:iso639_1] == 'en' ? 5 : rand(1..4)
  end

  def tags
    if place[0][:currencies][0][:code] == 'USD'
      ['usd', 'soon']
    else
      ["#{place[0][:currencies][0][:code].downcase}", 'maybe']
    end
  end
end
