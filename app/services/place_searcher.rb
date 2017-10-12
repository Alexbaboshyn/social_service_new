class PlaceSearcher
  def initialize params
    params = params.symbolize_keys || {}

    @city = params[:city]

    @tags = params[:tags]

    @range = params[:range]

    @current_user = params[:current_user]

    @id = params[:id]
  end

  def search_by_id
    place = Place.find_by(id: @id)

    if place == nil
      place = Place.where('city ILIKE?', "%#{ @id }%")
    end

    place
  end

  def search
    places = Place.all

    if @range.present?
      places = Place.where('earth_box(ll_to_earth(?, ?), ?) @> ll_to_earth(places.lat, places.lng)', @current_user.lat, @current_user.lng, @range)
    end

    places = places.where('city ILIKE?', "%#{ @city }%") if @city.present?

    places = places.where("'#{ @tags }' = ANY (tags)") if @tags.present?

    places
  end
end
