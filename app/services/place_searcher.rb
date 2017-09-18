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
    places = @range.present? ? Place.within_radius(@range, @current_user.lat, @current_user.lng).all : Place.all
    # places = Place.find_by_sql("SELECT * FROM places WHERE earth_box(ll_to_earth("@current_user"."lat", "@current_user"."lng"), 1000) @> ll_to_earth(lat, lng)", )
    places = places.where(city: @city.capitalize) if @city.present?

    places = places.where("'#{ @tags }' = ANY (tags)") if @tags.present?

    places
  end
end
