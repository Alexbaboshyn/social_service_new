class PlaceSearcher
  attr_accessor :city, :range, :tags, :current_user

  def initialize params
    params = params.symbolize_keys || {}

    @city = params[:city]

    @tags = params[:tags]

    @range = params[:range]

    @current_user = params[:current_user]
  end

  def search
    places = Place.all

    if @range.present?
      places = Place.where('earth_box(ll_to_earth(?, ?), ?) @> ll_to_earth(places.lat, places.lng)', @current_user.lat, @current_user.lng, @range)
    end

    places = places.where(city: @city.capitalize) if @city.present?

    places = places.where("'#{ @tags }' = ANY (tags)") if @tags.present?

    places
  end
end
